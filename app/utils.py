import bcrypt
from fastapi import HTTPException


def hash_password(password: str) -> str:
    """
    Haszuje hasło przy użyciu bcrypt.

    Args:
        password (str): Hasło w postaci tekstowej.

    Returns:
        str: Zahaszowane hasło w postaci zakodowanego ciągu znaków.
    """
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """
    Porównuje podane hasło z zahaszowanym hasłem.

    Args:
        plain_password (str): Hasło w postaci tekstowej.
        hashed_password (str): Zahaszowane hasło.

    Returns:
        bool: True, jeśli hasło pasuje, False w przeciwnym razie.
    """
    return bcrypt.checkpw(plain_password.encode('utf-8'), hashed_password.encode('utf-8'))


def get_user_by_email(db, email):
    try:
        with db.cursor() as cursor:
            query = "SELECT * FROM users WHERE email = %s;"
            cursor.execute(query, (email,))
            return cursor.fetchone()
    except Exception as e:
        print("Error fetching user by email:", e)
        raise


def save_game_history(db, user_id: str, game_name: str, bet_amount: float, result: str, payout: float):
    try:
        query = """
        INSERT INTO game_histories (user_id, game_name, bet_amount, result, payout)
        VALUES (%s, %s, %s, %s, %s);
        """
        with db.cursor() as cursor:
            cursor.execute(query, (user_id, game_name, bet_amount, result, payout))
            db.commit()
    except Exception as e:
        db.rollback()
        print(f"Error saving game history: {e}")
        raise HTTPException(status_code=500, detail="Failed to save game history")
