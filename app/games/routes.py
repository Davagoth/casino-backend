from fastapi import APIRouter, Depends, HTTPException
from pydantic import validator

from app.games.blackjack import play_blackjack_with_balance, play_blackjack_interactive, BlackjackPlayRequest, BlackjackBetRequest
from app.games.roulette import spin_roulette
from app.db import get_db
from app.games.roulette import RouletteRequest
from app.games.slots import SpinRequest, spin_slots
from app.games import blackjack

games_router = APIRouter()



@games_router.post("/blackjack/play")
def blackjack_interaction(data: BlackjackPlayRequest, db=Depends(get_db)):
    return play_blackjack_interactive(data, db)

@games_router.post("/blackjack/bet")
def blackjack_bet(data: BlackjackBetRequest, db=Depends(get_db)):
    return play_blackjack_with_balance(data, db)

@games_router.post("/roulette")
def play_roulette(data: RouletteRequest, db=Depends(get_db)):
    return spin_roulette(data, db)

@games_router.post("/slots/spin")
def play_slots(data: SpinRequest, db=Depends(get_db)):
    return spin_slots(data, db)

@games_router.post("/blackjack/action")
async def blackjack_action(data: BlackjackPlayRequest, db=Depends(get_db)):
    """
    Obsługuje akcję 'hit' lub 'stand' w trakcie gry
    """
    print("Received player hand:", data.player_hand)  # Zaloguj karty gracza
    print("Received dealer hand:", data.dealer_hand)  # Zaloguj karty dealera
    result = play_blackjack_interactive(data, db)
    if result is None:
        raise HTTPException(status_code=400, detail="Failed to process action")
    return result
