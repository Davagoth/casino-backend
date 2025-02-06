from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel, field_validator
import random
from app.games.transactions import update_balance
from app.utils import save_game_history
from app.db import get_db

app = FastAPI()

class RouletteRequest(BaseModel):
    login: str
    bet_type: str  # "color", "number", "range"
    bet_value: str  # "red", "black", "green", number (0-36), or "1-18"/"19-36"
    bet_amount: float

    @field_validator("bet_amount")
    @classmethod
    def validate_bet_amount(cls, v):
        if v <= 0:
            raise HTTPException(status_code=400, detail="Amount must be a positive number.")
        if v != int(v):  # Sprawdza, czy liczba nie ma miejsc dziesiętnych
            raise HTTPException(status_code=400, detail="Amount must be a whole number.")
        return v

    @field_validator("bet_value")
    @classmethod
    def validate_bet_value(cls, v):  # Nie potrzebujemy 'values'
        allowed_colors = {"red", "black", "green"}
        allowed_ranges = {"1-18", "19-36"}

        try:
            number = int(v)  # Sprawdzamy, czy da się przekonwertować na int
            if 0 <= number <= 36:  # Jeśli tak, to sprawdzamy zakres
                return str(number) # Konwertujemy spowrotem na string, bo takie jest pole bet_value
        except ValueError:
            pass  # Jeśli nie da się przekonwertować na int, to sprawdzamy inne opcje

        if v in allowed_colors or v in allowed_ranges:
            return v

        raise HTTPException(status_code=400, detail="Invalid bet value. Must be a number between 0 and 36.")



# Roulette function (game logic remains unchanged)
def spin_roulette(request_data: RouletteRequest, db=Depends(get_db)):
    with db.cursor() as cursor:
        cursor.execute("SELECT balance FROM users WHERE login = %s", (request_data.login,))
        user_balance = cursor.fetchone()
        if not user_balance:
            raise HTTPException(status_code=404, detail="User not found")
        balance = user_balance["balance"]

    if request_data.bet_amount > balance:
        raise HTTPException(status_code=400, detail="Insufficient funds.")

    RouletteRequest.validate_bet_amount(request_data.bet_amount)

    result = random.randint(0, 36)  # Roll a number between 0-36
    payout = 0

    # Determine the color of the result
    if result == 0:
        result_color = "green"
    elif result % 2 == 1:  # Odd numbers are red
        result_color = "red"
    else:  # Even numbers are black
        result_color = "black"

    # Calculate the payout based on the bet type
    if request_data.bet_type == "color" and request_data.bet_value == result_color:
        payout = request_data.bet_amount * (15 if result_color == "green" else 2)  # Green pays 15x, other colors 2x
    elif request_data.bet_type == "number" and int(request_data.bet_value) == result:
        payout = request_data.bet_amount * 36  # Bet on a specific number pays 36x
    elif request_data.bet_type == "range":
        if request_data.bet_value == "1-18" and 1 <= result <= 18:
            payout = request_data.bet_amount * 2  # Bet on range 1-18 pays 2x
        elif request_data.bet_value == "19-36" and 19 <= result <= 36:
            payout = request_data.bet_amount * 2  # Bet on range 19-36 pays 2x

    # Calculate net gain (winnings - bet)
    net_gain = payout - request_data.bet_amount

    # Update user balance and return the new balance
    new_balance = update_balance(db, request_data.login, net_gain)

    # Save game history
    query_check_user = "SELECT user_id FROM users WHERE login = %s"
    with db.cursor() as cursor:
        cursor.execute(query_check_user, (request_data.login,))
        user = cursor.fetchone()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        user_id = user["user_id"]

    # Save roulette result in history
    save_game_history(
        db,
        user_id,
        "roulette",
        request_data.bet_amount,
        "win" if payout > 0 else "lose",
        payout,
    )

    # Return game result, color, payout, and new balance
    return {"result": result, "color": result_color, "payout": payout, "new_balance": new_balance}