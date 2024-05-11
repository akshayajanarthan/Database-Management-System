import tkinter as tk
from tkinter import ttk
import mysql.connector

def connect_to_database():
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="AKshaya0301@#$",  # Change this to your MySQL password
            database="employees_database"  # Ensure this database exists
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

def add_record(table, data):
    db, _ = connect_to_database()
    if db:
        try:
            cursor = db.cursor()
            cursor.execute(f"INSERT INTO {table} VALUES ({', '.join(['%s'] * len(data))})", data)
            db.commit()
            print(f"{table.capitalize()} added successfully!")
        except mysql.connector.Error as e:
            print(f"Error adding {table.lower()}: {e}")
        finally:
            cursor.close()
            db.close()

def create_window(title, fields, action):
    window = tk.Tk()
    window.title(title)
    entry_vars = [tk.StringVar() for _ in fields]

    for i, (label_text, _) in enumerate(fields):
        tk.Label(window, text=label_text).grid(row=i, column=0, sticky="e", padx=5, pady=5)
        tk.Entry(window, textvariable=entry_vars[i]).grid(row=i, column=1, padx=5, pady=5)

    tk.Button(window, text="Submit", command=lambda: action([var.get() for var in entry_vars])).grid(row=len(fields), column=0, columnspan=2, pady=5)
    window.mainloop()

def employee_action(role, entry_vars):
    employee_fields = {
        "login": (["Login",("Login ID:", ""), ("Username:", ""), ("Password:", "")]),
        "train": ("Train", [("Train ID:", ""), ("Train Name:", ""),("Source Station:",""),("Destination Station:",""),("Depature Time",""),("Arrival Time","")]),
        "passenger":("Passenger",[("Passenger ID:",""),("Name:",""),("Gender:",""),("Contact Number:",""),("Email:","")]),
        "ticket":("Ticket",[("Ticket ID:",""),("Train ID:",""),("Passenger ID",""),("Seat Number:",""),("Class:",""),("Fare","")]),
        "station":("Station",[("Station ID:",""),("Station Name:",""),("Location:",""),("Zone:","")]),
        "schedule":("Schedule",[("Schedule ID:",""),("Train ID",""),("Station ID:",""),("Arrival Time:",""),("Departure Time:","")]),
        "booking":("Bookinkg"[("Booking ID:",""),("Booking Type:",""),("Booking Date",""),("Passenger ID","")]),
        # Add more tables if needed
    }
    table, _ = employee_fields[role]
    add_record(table, entry_vars)

def project_action(entry_vars):
    add_record("projects", entry_vars)

def project_employee_action(entry_vars):
    add_record("project_employee", entry_vars)

def open_management_system(user_role):
    global root
    root.destroy()
    fields = {
        "login": [("Login ID:", ""), ("Username:", ""), ("Password:", "")],
        "train": [("Train ID:", ""), ("Train Name:", ""),("Source Station:",""),("Destination Station:",""),("Depature Time",""),("Arrival Time","")],
        "passenger":[("Passenger ID:",""),("Name:",""),("Gender:",""),("Contact Number:",""),("Email:","")],
        "ticket":[("Ticket ID:",""),("Train ID:",""),("Passenger ID",""),("Seat Number:",""),("Class:",""),("Fare","")],
        "station":[("Station ID:",""),("Station Name:",""),("Location:",""),("Zone:","")],
        "schedule":[("Schedule ID:",""),("Train ID",""),("Station ID:",""),("Arrival Time:",""),("Departure Time:","")],
        "booking":[("Booking ID:",""),("Booking Type:",""),("Booking Date",""),("Passenger ID","")],
        # Add more roles if needed
    }[user_role]
    create_window(f"{user_role.capitalize()} Management System", fields, lambda vars: employee_action(user_role, vars) if user_role != "project" else project_action(vars))

def create_selection_window():
    global root
    root = tk.Tk()
    root.title("Entity Selection")
    tk.Label(root, text="Select an entity to manage:").pack(pady=10)

    for name in ["Login", "Train", "Passenger", "Ticket", "Station", "Schedule", "Booking"]:
        ttk.Button(root, text=name.replace("_", " ").capitalize(), command=lambda r=name.lower(): open_management_system(r)).pack(fill='x', expand=True, padx=20, pady=5)
    root.mainloop()

create_selection_window()
