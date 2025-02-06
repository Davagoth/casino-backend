import random
import string
from fastapi import APIRouter, Depends, HTTPException
from app.db import get_db
from app.utils import hash_password, verify_password
from pydantic import BaseModel, field_validator, ValidationError
import re

auth_router = APIRouter()


# Modele Pydantic z walidacją
class RegisterRequest(BaseModel):
    login: str
    email: str
    password: str

    @field_validator("login")
    @classmethod
    def validate_login(cls, v):
        if len(v) < 3:
            raise HTTPException(status_code=400, detail="Username must have at least 3 signs.")
        if len(v) > 20:
            raise HTTPException(status_code=400, detail="Username must have at most 20 signs.")
        if not v.isalnum():
            raise HTTPException(status_code=400, detail="Username must have letters and numbers only.")
        return v

    @field_validator("email")
    @classmethod
    def validate_email(cls, v):
        if "@" not in v or "." not in v.split("@")[-1]:
            raise HTTPException(status_code=400, detail="Give correct e-mail.")
        return v

    @field_validator("password")
    @classmethod
    def validate_password(cls, v):
        if len(v) < 6:
            raise HTTPException(status_code=400, detail="Password must contain at least 6 signs.")
        return v


class LoginRequest(BaseModel):
    login: str
    password: str


class AddBalanceRequest(BaseModel):
    login: str
    amount: float

    @field_validator("amount")
    @classmethod
    def validate_amount(cls, v):
        if v <= 0:
            raise HTTPException(status_code=400, detail="Amount must be a positive number.")
        if v != int(v):  # Sprawdza, czy liczba nie ma miejsc dziesiętnych
            raise HTTPException(status_code=400, detail="Amount must be a whole number.")
        return v


class BalanceRequest(BaseModel):
    login: str


def generate_user_id():
    return ''.join(random.choices(string.ascii_letters + string.digits, k=16))


# Sprawdzanie siły hasła
def validate_password(password: str):
    if not re.search(r"[A-Z]", password) or not re.search(r"\d", password):
        raise HTTPException(status_code=400, detail="Password must contain at least one uppercase letter and one digit.")


# Sprawdzanie, czy login i email są już w bazie
def check_existing_user(db, login, email):
    with db.cursor() as cursor:
        cursor.execute("SELECT 1 FROM users WHERE login = %s OR email = %s", (login, email))
        if cursor.fetchone():
            raise HTTPException(status_code=400, detail="Login or email already exists.")


def create_user(db, login, email, hashed_password):
    try:
        with db.cursor() as cursor:
            # Generowanie unikalnego user_id
            while True:
                user_id = generate_user_id()
                cursor.execute("SELECT 1 FROM users WHERE user_id = %s", (user_id,))
                if not cursor.fetchone():
                    break  # Jeżeli user_id nie istnieje w bazie, przerywamy pętlę

            # Wstawianie nowego użytkownika
            query = """
            INSERT INTO users (user_id, login, email, hashed_password)
            VALUES (%s, %s, %s, %s);
            """
            cursor.execute(query, (user_id, login, email, hashed_password))
            db.commit()

    except Exception as e:
        db.rollback()
        print("Error creating user:", e)
        raise HTTPException(status_code=500, detail="Could not create user")


# Rejestracja użytkownika
@auth_router.post("/register")
def register_user(request: RegisterRequest, db=Depends(get_db)):
    try:
        hashed_password = hash_password(request.password)
        create_user(db, request.login, request.email, hashed_password)
        return {"message": "User registered successfully"}

    except ValidationError as e:
        errors = [err["msg"] for err in e.errors()]
        raise HTTPException(status_code=400, detail=errors)

    except HTTPException as e:
        raise e

    except Exception:
        raise HTTPException(status_code=500, detail="Server error during registration.")


# Logowanie użytkownika
@auth_router.post("/login")
def login_user(request: LoginRequest, db=Depends(get_db)):
    try:
        with db.cursor() as cursor:
            # Pobierz login, hashed_password oraz balance użytkownika
            query = """
            SELECT login, hashed_password, email, balance 
            FROM users 
            WHERE login = %s;
            """
            cursor.execute(query, (request.login,))
            user = cursor.fetchone()

            if not user or not verify_password(request.password, user["hashed_password"]):
                raise HTTPException(status_code=401, detail="Invalid credentials")

            # Jeśli dane są poprawne, zwracamy szczegóły użytkownika
            return {
                "message": f"Login successful. Welcome {user['login']}",
                "user": {
                    "login": user['login'],
                    "email": user['email'],
                    "balance": user['balance']
                }
            }
    except Exception as e:
        raise HTTPException(status_code=500, detail="Login Failed. Wrong password or user does not exist.")


# Dodawanie środków do konta
@auth_router.post("/balance/add")
def add_balance(request: AddBalanceRequest, db=Depends(get_db)):
    try:
        with db.cursor() as cursor:
            query = "UPDATE users SET balance = balance + %s WHERE login = %s RETURNING balance;"
            cursor.execute(query, (request.amount, request.login))
            result = cursor.fetchone()
            if not result:
                raise HTTPException(status_code=404, detail="User not found")
            db.commit()
            return {"login": request.login, "new_balance": result["balance"]}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail="Failed to add balance")


@auth_router.post("/balance/remove")
def remove_balance(request: AddBalanceRequest, db=Depends(get_db)):
    try:
        with db.cursor() as cursor:
            query = "UPDATE users SET balance = balance - %s WHERE login = %s RETURNING balance;"
            cursor.execute(query, (request.amount, request.login))
            result = cursor.fetchone()
            if not result:
                raise HTTPException(status_code=404, detail="User not found")
            db.commit()
            return {"login": request.login, "new_balance": result["balance"]}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail="Failed to remove balance")


# Pobieranie salda użytkownika
@auth_router.get("/balance")
def get_balance(request: BalanceRequest, db=Depends(get_db)):
    try:
        with db.cursor() as cursor:
            query = "SELECT balance FROM users WHERE login = %s;"
            cursor.execute(query, (request.login,))
            result = cursor.fetchone()
            if not result:
                raise HTTPException(status_code=404, detail="User not found")
            return {"login": request.login, "balance": result["balance"]}
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to retrieve balance")


# Pobieranie danych użytkownika na podstawie loginu
@auth_router.get("/profile")
def get_profile(login: str, db=Depends(get_db)):
    try:
        with db.cursor() as cursor:
            query = "SELECT login, email, balance FROM users WHERE login = %s;"
            cursor.execute(query, (login,))
            user = cursor.fetchone()

            if not user:
                raise HTTPException(status_code=404, detail="User not found")

            return {
                "login": user['login'],
                "email": user['email'],
                "balance": user['balance']
            }
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to retrieve user profile")
