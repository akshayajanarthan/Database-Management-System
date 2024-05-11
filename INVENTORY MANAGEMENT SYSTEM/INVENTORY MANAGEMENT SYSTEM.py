import tkinter as tk
from tkinter import ttk
import mysql.connector

def connect_to_database():
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="AKshaya0301@#$",  # Change this to your MySQL password
            database="inventory_database"  # Ensure this database exists
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
        "product": ("products", [("Product ID:", ""), ("Name:", ""), ("Description:", ""), ("Quantity In Stock:", ""), ("Price:", ""), ("Category ID:", ""), ("Supplier ID:", "")]),
        "supplier": ("suppliers", [("Supplier ID:", ""), ("Name:", ""), ("Contact Info:", "")]),
        "category": ("categories", [("Category ID:", ""), ("Name:", ""), ("Description:", "")]),
        "order": ("orders", [("Order ID:", ""), ("Date:", ""), ("Total Amount:", ""), ("Customer ID:", "")]),
        "customer": ("customers", [("Customer ID:", ""), ("Name:", ""), ("Contact Info:", "")]),
        # Add more tables if needed
    }
    table, _ = inventory_fields[role]
    add_record(table, entry_vars)

def open_management_system(user_role):
    global root
    root.destroy()
    fields = {
        "product": [("Product ID:", ""), ("Name:", ""), ("Description:", ""), ("Quantity In Stock:", ""), ("Price:", ""), ("Category ID:", ""), ("Supplier ID:", "")],
        "supplier": [("Supplier ID:", ""), ("Name:", ""), ("Contact Info:", "")],
        "category": [("Category ID:", ""), ("Name:", ""), ("Description:", "")],
        "order": [("Order ID:", ""), ("Date:", ""), ("Total Amount:", ""), ("Customer ID:", "")],
        "customer": [("Customer ID:", ""), ("Name:", ""), ("Contact Info:", "")],
        # Add more roles if needed
    }[user_role]
    create_window(f"{user_role.capitalize()} Management System", fields, lambda vars: inventory_action(user_role, vars))

def create_selection_window():
    global root
    root = tk.Tk()
    root.title("Entity Selection")
    tk.Label(root, text="Select an entity to manage:").pack(pady=10)

    for name in ["Product", "Supplier", "Category", "Order", "Customer"]:
        ttk.Button(root, text=name, command=lambda r=name.lower(): open_management_system(r)).pack(fill='x', expand=True, padx=20, pady=5)
    root.mainloop()

create_selection_window()
