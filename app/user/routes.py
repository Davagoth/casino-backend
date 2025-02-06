from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException
from typing import List, Union
from pydantic import BaseModel
from app.db import get_db

# Model do zwracania historii gier
class GameHistoryResponse(BaseModel):
    game_name: str
    bet_amount: float
    result: str
    payout: float
    timestamp: datetime


class Login(BaseModel):
    login: str


# Rejestracja routera dla historii gier
user_router = APIRouter()


# Funkcja pomocnicza do pobierania historii gier
def get_history_for_game(login: str, game_name: str, db) -> Union[List[GameHistoryResponse], str]:
    query = """
    SELECT game_name, bet_amount, result, payout, played_at
    FROM game_histories
    WHERE user_id = (SELECT user_id FROM users WHERE login = %s) AND game_name = %s
    ORDER BY played_at DESC
    """

    with db.cursor() as cursor:
        cursor.execute(query, (login, game_name))
        results = cursor.fetchall()

        if not results:
            return f"No {game_name} game history found for this user"

        return [GameHistoryResponse(
            game_name=row["game_name"],
            bet_amount=row["bet_amount"],
            result=row["result"],
            payout=row["payout"],
            timestamp=row["played_at"]
        ) for row in results]


# Endpoint dla historii "Slots"
@user_router.get("/game-history/slots/{login}", response_model=List[GameHistoryResponse])
def get_slots_history(login: str, db=Depends(get_db)):
    result = get_history_for_game(login, "slots", db)
    if isinstance(result, str):  # Jeśli wynik to komunikat o braku historii
        raise HTTPException(status_code=404, detail=result)
    return result


# Endpoint dla historii "Blackjack"
@user_router.get("/game-history/blackjack/{login}", response_model=List[GameHistoryResponse])
def get_blackjack_history(login: str, db=Depends(get_db)):
    result = get_history_for_game(login, "blackjack", db)
    if isinstance(result, str):  # Jeśli wynik to komunikat o braku historii
        raise HTTPException(status_code=404, detail=result)
    return result


# Endpoint dla historii "Roulette"
@user_router.get("/game-history/roulette/{login}", response_model=List[GameHistoryResponse])
def get_roulette_history(login: str, db=Depends(get_db)):
    result = get_history_for_game(login, "roulette", db)
    if isinstance(result, str):  # Jeśli wynik to komunikat o braku historii
        raise HTTPException(status_code=404, detail=result)
    return result
