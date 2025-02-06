import random
from fastapi import HTTPException, Depends
from pydantic import BaseModel, field_validator
from typing import List, Dict
from app.utils import save_game_history
from app.games.transactions import update_balance

from app.db import get_db


class Card(BaseModel):
    rank: str
    suit: str
    value: int


# Modele Pydantic
class BlackjackPlayRequest(BaseModel):
    action: str
    bet_amount: float  # Zmieniamy na float
    dealer_hand: List[Card]
    login: str
    player_hand: List[Card]

    @field_validator("player_hand", "dealer_hand", mode="before")
    def validate_hands(cls, hands):
        if isinstance(hands, list) and all(isinstance(card, dict) for card in hands):
            return [Card(**card) for card in hands]
        if all(isinstance(card, Card) for card in hands):
            return hands
        raise ValueError("Invalid format for cards")


class BlackjackBetRequest(BaseModel):
    login: str
    bet_amount: float

    @field_validator("bet_amount")
    @classmethod
    def validate_bet_amount(cls, v):
        if v <= 0:
            raise HTTPException(status_code=400, detail="Amount must be a positive number.")
        if v != int(v):  # Sprawdza, czy liczba nie ma miejsc dziesiętnych
            raise HTTPException(status_code=400, detail="Amount must be a whole number.")
        return v


SUITS = ["♠", "♥", "♦", "♣"]
RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
CARD_VALUES = {
    "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10,
    "J": 10, "Q": 10, "K": 10, "A": 11
}


def draw_card():
    suit = random.choice(SUITS)
    rank = random.choice(RANKS)
    card = {"rank": rank, "suit": suit, "value": CARD_VALUES[rank]}
    return card


def deal_initial_hands():
    player_hand = [draw_card() for _ in range(2)]
    dealer_hand = [draw_card() for _ in range(2)]
    return player_hand, dealer_hand


# Funkcje blackjack
def hit(hand):
    deck = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
    hand.append(random.choice(deck))
    return hand


# Zaktualizowana funkcja evaluate_hand
def evaluate_hand(hand: List[Card]) -> int:
    total = sum(card.value for card in hand)  # card.value zamiast card["value"]
    aces = sum(1 for card in hand if card.rank == 'A')  # Liczenie asów

    # Dostosowanie punktów, jeśli są asy (zmiana wartości A w zależności od potrzeby)
    while total > 21 and aces:
        total -= 10  # Zmieniamy as z 11 na 1
        aces -= 1

    return total


def play_blackjack_interactive(data: BlackjackPlayRequest, db):
    with db.cursor() as cursor:
        cursor.execute("SELECT balance FROM users WHERE login = %s", (data.login,))
        user_balance_row = cursor.fetchone()  # Get the entire row
        if not user_balance_row:
            raise HTTPException(status_code=404, detail="User not found")
        balance = user_balance_row["balance"]  # Access the balance value

    if data.bet_amount > balance:
        raise HTTPException(status_code=400, detail="Insufficient funds.")

    # Upewniamy się, że player_hand i dealer_hand są zawsze zainicjalizowane
    player_hand = data.player_hand
    dealer_hand = data.dealer_hand

    if data.action == "hit":
        # Dodanie nowej karty do ręki gracza
        new_card = draw_card()
        player_hand.append(Card(**new_card))  # Tworzymy obiekt `Card` na podstawie losowanej karty
        print(f"Player hit and drew card: {new_card}")

    if data.action == "stand":
        dealer_score = evaluate_hand(dealer_hand)
        while dealer_score < 17:
            new_card = draw_card()
            dealer_hand.append(Card(**new_card))  # Tworzymy obiekt `Card` na podstawie losowanej karty
            dealer_score = evaluate_hand(dealer_hand)

    # Obliczamy wyniki gracza i dealera
    player_score = evaluate_hand(player_hand)
    dealer_score = evaluate_hand(dealer_hand)
    print("Current player hand:", player_hand)  # Zaloguj karty gracza
    print("Current dealer hand:", dealer_hand)  # Zaloguj karty dealera
    print("player score:", player_score)
    print("dealer score:", dealer_score)
    # Inicjalizujemy wynik gry i wypłatę
    payout = 0
    result = ""
    result_message = ""

    # Logika wyników
    if player_score > 21:
        result = "bust"
        result_message = "You busted! You lose your bet."
    elif player_score == 21:
        result = "win"
        payout = data.bet_amount * 3
        result_message = f"Blackjack! You win {payout}."
    elif dealer_score > 21:
        result = "win"
        payout = data.bet_amount * 2
        result_message = f"Dealer busted! You win {payout}."
    elif dealer_score > 16 and player_score > dealer_score:
        result = "win"
        payout = data.bet_amount * 2
        result_message = f"Congratulations! You win {payout}."
    elif dealer_score > 16 and player_score < dealer_score:
        result = "lose"
        result_message = "You lose! Better luck next time."
    elif dealer_score == player_score:
        result = "tie"
        result_message = "It's a tie! No winner, no loser."
        payout = data.bet_amount

    # Sprawdzamy ponownie użytkownika (opcja redundantna, ale zostawiona na wypadek rozszerzeń)
    query_check_user = "SELECT user_id FROM users WHERE login = %s"
    with db.cursor() as cursor:
        cursor.execute(query_check_user, (data.login,))
        user = cursor.fetchone()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        user_id = user["user_id"]

    # Zwracamy wynik gry z komunikatem
    return {
        "result": result,  # Zwracamy szczegółowy komunikat
        "result_message": result_message,
        "player_hand": [f"{card.rank} of {card.suit}" for card in player_hand],
        "player_score": player_score,
        "dealer_hand": [f"{card.rank} of {card.suit}" for card in dealer_hand],
        "dealer_score": dealer_score,
        "payout": payout  # Dodajemy kwotę wygranej
    }


def play_blackjack_with_balance(data: BlackjackBetRequest, db=Depends(get_db)):
    with db.cursor() as cursor:
        cursor.execute("SELECT balance FROM users WHERE login = %s", (data.login,))
        user_balance_row = cursor.fetchone()  # Get the entire row
        if not user_balance_row:
            raise HTTPException(status_code=404, detail="User not found")
        balance = user_balance_row["balance"]  # Access the balance value

    if data.bet_amount > balance:
        raise HTTPException(status_code=400, detail="Insufficient funds.")

    # Losowanie kart startowych dla gracza i dealera
    initial_player_hand, initial_dealer_hand = deal_initial_hands()

    # Przekształcanie kart na obiekty Card
    player_hand = [Card(**card) for card in initial_player_hand]
    dealer_hand = [Card(**card) for card in initial_dealer_hand]

    result = play_blackjack_interactive(
        BlackjackPlayRequest(
            action="start",  # Może być inne działanie w zależności od logiki gry
            player_hand=player_hand,
            dealer_hand=dealer_hand,
            bet_amount=data.bet_amount,
            login=data.login
        ), db)

    # Aktualizacja stanu konta na podstawie wyniku
    if result["result"] == "win":
        update_balance(db, data.login, data.bet_amount)
    elif result["result"] == "bust":
        update_balance(db, data.login, -data.bet_amount)

    return result
