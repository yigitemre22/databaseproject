import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="123456",
    database="pastahane"
)

def get_cursor():
    if not db.is_connected():
        db.reconnect()
    return db.cursor(dictionary=True)