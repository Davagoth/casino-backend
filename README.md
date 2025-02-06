# Casino Backend

Casino Backend is the server-side component of an online casino application, handling game logic, user management, and database interactions.

## 🚀 Technologies

This project utilizes the following technologies:

- **Python** – main backend language
- **FastAPI** – framework for building APIs

## 📦 Project Structure

```
casino-backend/
├── .idea/          # IDE configuration
├── alembic/        # Database migration files
├── app/            # Main application logic
│   ├── models/     # SQLAlchemy models
│   ├── routes/     # API endpoints
│   ├── services/   # Business logic
│   ├── main.py     # Main application file
├── alembic.ini     # Alembic configuration
└── backup.sql      # Database dump
```

## 🛠 Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Davagoth/casino-backend.git
   ```
2. **Navigate to the project directory:**
   ```sh
   cd casino-backend
   ```
3. **Create and activate a virtual environment:**
   ```sh
   python -m venv venv
   source venv/bin/activate  # Linux/macOS
   venv\Scripts\activate     # Windows
   ```
4. **Install dependencies:**
   ```sh
   pip install -r requirements.txt
   ```
5. **Run database migrations:**
   ```sh
   alembic upgrade head
   ```
6. **Start the server:**
   ```sh
   uvicorn app.main:app --reload
   ```

## 🔥 API Endpoints

Key API endpoints available in the project:

- `POST /register` – register a new user
- `POST /login` – user login
- `POST /add-balance` – add funds to account
- `GET /games` – retrieve available games list
- `POST /play/{game_name}` – start a game

API documentation is available at:
```
http://127.0.0.1:8000/docs
```

## 📌 Database Configuration

This project uses **PostgreSQL**. You can change the database configuration in the `.env` file:
```
DATABASE_URL=postgresql://user:password@localhost:5432/casino_db
```

To create the database:
```sh
psql -U postgres -c "CREATE DATABASE casino_db;"
```

To restore from backup:
```sh
psql -h localhost -p 5432 -U postgres -d Casino_App_Database -f D:/backup.sql
```

