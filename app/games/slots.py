from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel, field_validator
import random
from app.games.transactions import update_balance
from app.utils import save_game_history

app = FastAPI()

# Slot game symbols
SYMBOLS = ["🍊", "🍒", "🍋", "🍉", "🍇", "🍓", "🍌", "⭐", "🍐", "🥕", "🍆", "🍍", "🍎", "🍑", "🥝", "🔔"]


# Request and response models
class SpinRequest(BaseModel):
    login: str
    bet: float

    @field_validator("bet")
    @classmethod
    def validate_bet(cls, v):
        if v <= 0:
            raise HTTPException(status_code=400, detail="Amount must be a positive number.")
        if v != int(v):  # Sprawdza, czy liczba nie ma miejsc dziesiętnych
            raise HTTPException(status_code=400, detail="Amount must be a whole number.")
        return v


class SpinResponse(BaseModel):
    reels: list
    winnings: int
    message: str
    message_class: str


def spin_slots(request: SpinRequest, db):
    # Get user balance
    query_balance = "SELECT balance FROM users WHERE login = %s"
    with db.cursor() as cursor:
        cursor.execute(query_balance, (request.login,))
        user = cursor.fetchone()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        balance = user["balance"]

    try:
        SpinRequest.validate_bet(request.bet)  # Validate bet
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))  # Catch and re-raise as HTTPException

    if request.bet > balance:
        raise HTTPException(status_code=400, detail="Insufficient funds in the account.")

    # Draw symbols on the reels
    reels = [
        [random.choice(SYMBOLS) for _ in range(3)],
        [random.choice(SYMBOLS) for _ in range(3)],
        [random.choice(SYMBOLS) for _ in range(3)],
    ]

    # Game logic
    winnings = 0
    message = "You lost! Try your luck again!"
    message_class = "lose"

    if reels[1].count(reels[1][0]) == 3:  # Jackpot: 3 identical symbols in the middle row
        winnings = request.bet * 10
        message = f" Jackpot! You won ${winnings}!"
        message_class = "jackpot"
    elif (
            reels[1][0] == reels[1][1]
            or reels[1][0] == reels[1][2]
            or reels[1][1] == reels[1][2]
    ):  # Two identical symbols in the middle row
        winnings = request.bet * 2
        message = f"You matched two symbols and won ${winnings}!"
        message_class = "win"

    # Calculate new balance
    net_gain = winnings - request.bet
    update_balance(db, request.login, net_gain)

    # Save game history
    query_check_user = "SELECT user_id FROM users WHERE login = %s"
    with db.cursor() as cursor:
        cursor.execute(query_check_user, (request.login,))
        user = cursor.fetchone()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        user_id = user["user_id"]

    save_game_history(
        db,
        user_id,
        "slots",
        request.bet,
        "win" if winnings > 0 else "lose",
        winnings,
    )

    return SpinResponse(
        reels=reels,
        winnings=winnings,
        message=message,
        message_class=message_class,
    )
