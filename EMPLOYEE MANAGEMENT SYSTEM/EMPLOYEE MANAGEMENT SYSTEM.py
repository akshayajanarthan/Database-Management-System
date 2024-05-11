import tkinter as tk
from tkinter import ttk
import mysql.connector

def connect_to_database():
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="AKshaya0301@#$",  # Change this to your MySQL password
            database="employee_database"  # Ensure this database exists
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
        "employee": ("employees", [("Employee ID:", ""), ("First Name:", ""), ("Last Name:", ""), ("Email:", ""), ("Phone Number:", ""), ("Hire Date:", "")]),
        "department": ("departments", [("Department ID:", ""), ("Department Name:", "")]),
        "position": ("positions", [("Position ID:", ""), ("Position Title:", "")]),
        "salary": ("salaries", [("Salary ID:", ""), ("Amount:", ""), ("Employee ID:", "")]),
        "attendance": ("attendance", [("Attendance ID:", ""), ("Employee ID:", ""), ("Date:", ""), ("Time In:", ""), ("Time Out:", "")]),
        "leave": ("leave", [("Leave ID:", ""), ("Employee ID:", ""), ("Start Date:", ""), ("End Date:", ""), ("Reason:", "")]),
        "project": [("Project ID:", ""), ("Name:", ""), ("Description:", ""), ("Start Date:", ""), ("End Date:", "")],
        "project_employee": [("Project ID:", ""), ("Employee ID:", "")],
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
        "employee": [("Employee ID:", ""), ("First Name:", ""), ("Last Name:", ""), ("Email:", ""), ("Phone Number:", ""), ("Hire Date:", "")],
        "department": [("Department ID:", ""), ("Department Name:", "")],
        "position": [("Position ID:", ""), ("Position Title:", "")],
        "salary": [("Salary ID:", ""), ("Amount:", ""), ("Employee ID:", "")],
        "attendance": [("Attendance ID:", ""), ("Employee ID:", ""), ("Date:", ""), ("Time In:", ""), ("Time Out:", "")],
        "leave": [("Leave ID:", ""), ("Employee ID:", ""), ("Start Date:", ""), ("End Date:", ""), ("Reason:", "")],
        "project": [("Project ID:", ""), ("Name:", ""), ("Description:", ""), ("Start Date:", ""), ("End Date:", "")],
        "project_employee": [("Project ID:", ""), ("Employee ID:", "")]
        # Add more roles if needed
    }[user_role]
    create_window(f"{user_role.capitalize()} Management System", fields, lambda vars: employee_action(user_role, vars) if user_role != "project" else project_action(vars))

def create_selection_window():
    global root
    root = tk.Tk()
    root.title("Entity Selection")
    tk.Label(root, text="Select an entity to manage:").pack(pady=10)

    for name in ["Employee", "Department", "Position", "Salary", "Attendance", "Leave", "Project", "Project_Employee"]:
        ttk.Button(root, text=name.replace("_", " ").capitalize(), command=lambda r=name.lower(): open_management_system(r)).pack(fill='x', expand=True, padx=20, pady=5)
    root.mainloop()

create_selection_window()
