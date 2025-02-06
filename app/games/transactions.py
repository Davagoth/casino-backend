def update_balance(db, login: str, amount: float):
    try:
        # Przygotowanie zapytania SQL do aktualizacji balansu
        query = """
        UPDATE users
        SET balance = balance + %s
        WHERE login = %s
        RETURNING balance;
        """
        with db.cursor() as cursor:
            cursor.execute(query, (amount, login))
            updated_balance = cursor.fetchone()
            db.commit()

        if updated_balance:
            return updated_balance[0]
        else:
            return None

    except Exception as e:
        db.rollback()
        return None
