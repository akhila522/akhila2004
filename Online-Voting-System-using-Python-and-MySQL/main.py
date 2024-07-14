import sqlite3

# Function to create a connection to the SQLite database
def create_connection(db_file):
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print("Connection established.")
    except sqlite3.Error as e:
        print(f"Error connecting to database: {e}")
    return conn

# Function to create a new user in the User_Table
def create_user(conn):
    cursor = conn.cursor()
    try:
        VoterID = input("Enter Voter ID: ")
        Def_Password = input("Enter Default Password: ")
        isActive = bool(input("Enter isActive: "))
        AADHAAR = input("Enter AADHAAR: ")
        UserTypeID = int(input("Enter User Type ID: "))
        
        cursor.execute("""
            INSERT INTO User_Table (VoterID, Def_Password, isActive, AADHAAR, UserTypeID) 
            VALUES (?, ?, ?, ?, ?)
        """, (VoterID, Def_Password, isActive, AADHAAR, UserTypeID))
        
        conn.commit()
        print("User created successfully.")
    except sqlite3.Error as e:
        print(f"An error occurred: {e}")

# Main function to run the application
def main():
    database = "voting_system.db"
    conn = create_connection(database)
    if conn:
        while True:
            print("\n1. Create User\n2. Exit")
            choice = input("Enter your choice: ")
            if choice == '1':
                create_user(conn)
            elif choice == '2':
                break
            else:
                print("Invalid choice. Please try again.")

        conn.close()

if __name__ == '__main__':
    main()
