import mysql.connector

def connect_to_database():
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="AKshaya0301@#$",  # Change this to your MySQL password
            database="airlines_database"  # Ensure this database exists
        )
        if db.is_connected():
            print("Connected to MySQL server")
            return db, None
        else:
            print("Failed to connect to MySQL server")
            return None, None
    except mysql.connector.Error as e:
        print("Error connecting to MySQL:", e)
        return None, None