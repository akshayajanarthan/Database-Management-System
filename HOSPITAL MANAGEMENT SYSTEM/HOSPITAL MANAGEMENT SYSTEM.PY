import tkinter as tk
from tkinter import ttk
import mysql.connector

def connect_to_database():
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="AKshaya0301@#$",  # Change this to your MySQL password
            database="hospital_database"  # Ensure this database exists
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

def inventory_action(role, entry_vars):
    inventory_fields = {
        "patient": ("Patient", [("Patient ID:", ""), ("First Name:", ""), ("Last Name:", ""), ("DOB:", ""), ("Address:", ""), ("Phone Number:", "")]),
        "doctor": ("Doctor", [("Doctor ID:", ""), ("First Name:", ""), ("Last Name:", ""), ("Department ID:", "")]),
        "appointment": ("Appointment", [("Appointment ID:", ""), ("Patient ID:", ""), ("Doctor ID:", ""), ("Date:", ""), ("Time:", ""), ("Status:", "")]),
        "department": ("Department", [("Department ID:", ""), ("Department Name:", "")]),
        "medical_record": ("Medical_record", [("Record ID:", ""), ("Patient ID:", ""), ("Admission Date:", ""), ("Discharge Date:", "")]),
        "prescription": ("Prescription", [("Prescription ID:", ""), ("Record ID:", ""), ("Medication:", ""), ("Dosage:", "")]),
        "payment": ("Payment", [("Payment ID:", ""), ("Appointment ID:", ""), ("Amount Paid:", "")]),
    }
        # Add more tables if needed
    table, _ = inventory_fields[role]
    add_record(table, entry_vars)

def open_management_system(user_role):
    global root
    root.destroy()
    fields = {
        "patient": [("Patient ID:", ""), ("First Name:", ""), ("Last Name:", ""), ("DOB:", ""), ("Address:", ""), ("Phone Number:", "")],
        "doctor": [("Doctor ID:", ""), ("First Name:", ""), ("Last Name:", ""), ("Department ID:", "")],
        "appointment":[("Appointment ID:", ""), ("Patient ID:", ""), ("Doctor ID:", ""), ("Date:", ""), ("Time:", ""), ("Status:", "")],
        "department": [("Department ID:", ""), ("Department Name:", "")],
        "medical_record":[("Record ID:", ""), ("Patient ID:", ""), ("Admission Date:", ""), ("Discharge Date:", "")],
        "prescription":[("Prescription ID:", ""), ("Record ID:", ""), ("Medication:", ""), ("Dosage:", "")],
        "payment":[("Payment ID:", ""), ("Appointment ID:", ""), ("Amount Paid:", "")],
    }[user_role]
    create_window(f"{user_role.capitalize()} Management System", fields, lambda vars: inventory_action(user_role, vars))

def create_selection_window():
    global root
    root = tk.Tk()
    root.title("Entity Selection")
    tk.Label(root, text="Select an entity to manage:").pack(pady=10)

    for name in  "Patient", "Doctor", "Appointment", "Department", "Medical Record", "Prescription", "Payment":
        ttk.Button(root, text=name, command=lambda r=name.lower(): open_management_system(r)).pack(fill='x', expand=True, padx=20, pady=5)
    root.mainloop()

create_selection_window()
