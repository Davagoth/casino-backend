from fastapi import FastAPI
from app.auth.routes import auth_router
from app.games.routes import games_router
from app.user.routes import user_router
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI()

# Rejestracja endpointów
app.include_router(auth_router, prefix="/auth", tags=["Auth"])
app.include_router(games_router, prefix="/games", tags=["Games"])
app.include_router(user_router, prefix="/user", tags=["User"])

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {"message": "Casino Backend API - działa"}
