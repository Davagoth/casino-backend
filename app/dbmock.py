# Mockowa baza w pamięci
users = []
games = []

def add_user_mock(user):
    users.append(user)

def get_user_mock(email):
    for user in users:
        if user["email"] == email:
            return user
    return None

def record_game_mock(game_result):
    games.append(game_result)

def get_games_mock():
    return games
