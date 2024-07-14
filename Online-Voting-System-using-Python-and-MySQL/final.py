import mysql.connector as connector
from datetime import date
import random
import datetime

class VotingSystem:
    def __init__(self):
        self.db = connector.connect(host='localhost', port=3306, user='root', password='mysql', database='voting_system')
    
    def sign_up(self):
        while True:
            Aadhaar = input('Aadhaar number: ')
            if len(Aadhaar) != 12:
                print("Invalid length of Aadhaar no.!\n")
            elif Aadhaar.isnumeric():
                break
            else:
                print("Aadhaar no. can only contain numbers!\n")
        
        query = "SELECT FirstName FROM voter_table WHERE Aadhaar=%s"
        cur = self.db.cursor()
        cur.execute(query, (Aadhaar,))
        if cur.fetchone():
            print("You are already registered!\n")
            return
        
        while True:
            Fname = input("First Name: ").upper()
            Mname = input("Middle Name: ").upper()
            Lname = input("Last Name: ").upper()
            if Fname.isalpha() and Mname.isalpha() and Lname.isalpha():
                break
            else:
                print("Name can only contain characters!\n")
        
        while True:
            Sex = input("Gender(F/M/Other): ").upper()
            if Sex in ['F', 'M', 'OTHER']:
                break
            else:
                print("Please enter valid input!\n")
        
        while True:
            Birthday = input("Date of birth(YYYY-MM-DD): ")
            format = "%Y-%m-%d"
            isValidDate = True
            try:
                datetime.datetime.strptime(Birthday, format)
            except ValueError:
                isValidDate = False
            if isValidDate:
                break
            else:
                print("This is the incorrect date string format. It should be YYYY-MM-DD\n")
        
        year, month, day = map(int, Birthday.split("-"))
        Age = date.today().year - year - 1
        if Age < 18:
            print("\nYou are not eligible to vote. Sorry!\n")
            print("Bye!")
            quit()
        
        while True:
            Phone = input("Phone Number: ")
            if len(Phone) != 10:
                print("Invalid length of Phone no.!\n")
            elif Phone.isnumeric():
                Phone = int(Phone)
                break
            else:
                print("Phone no. can only contain numbers!\n")
        
        while True:
            Email = input("Email address: ")
            if '@' in Email and '.' in Email and Email.index("@") < Email.index(".") and Email.index(".") < len(Email) - 1:
                break
            else:
                print("Invalid Email Id !\n")
        
        print("\nEnter permanent address:")
        while True:
            locality = input("Locality: ")
            city = input("City: ")
            state = input("State: ")
            ZipCode = input("Zip Code: ")
            DistrictId = self.districtId(locality, city, state, ZipCode)
            if DistrictId is None:
                print("Please enter valid address\n")
                continue
            break
        
        while True:
            Password = input("Password: ")
            Confirm_pass = input("Confirm password: ")
            if Confirm_pass == Password:
                break
            else:
                print("Password doesn't match! Enter again!\n")
        
        query = "INSERT INTO voter_table VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values = (Aadhaar, Fname.upper(), Mname.upper(), Lname.upper(), Sex.upper(), Birthday, Age, Phone, Email.lower(), DistrictId)
        cur.execute(query, values)
        self.db.commit()
        VoterId = self.user_table(Fname, Lname, Aadhaar, Password)
        print("\nRegistration completed!\nPlease save the following voterId for future login\nVoterID: ", VoterId)
    
    def districtId(self, locality, city, state, ZipCode):
        query = "SELECT DistrictId FROM address WHERE locality=%s AND city=%s AND state=%s AND zipCode=%s"
        values = (locality.upper(), city.upper(), state.upper(), ZipCode)
        cur = self.db.cursor()
        cur.execute(query, values)
        distId = cur.fetchone()
        if distId:
            return distId[0]
        else:
            return None
    
    def user_table(self, Fname, Lname, Aadhaar, Password):
        vid = Fname[:2].upper() + Lname[0].upper() + str(random.randint(1000001, 9999999))
        query = "INSERT INTO user_table VALUES(%s, %s, %s)"
        values = (vid, Aadhaar, Password)
        cur = self.db.cursor()
        cur.execute(query, values)
        self.db.commit()
        return vid
    
    def login(self):
        while True:
            Aadhaar = input("Aadhaar Number: ")
            VoterId = input("VoterId: ")
            Password = input("Password: ")
            query = "SELECT _Password FROM user_table WHERE VoterId=%s AND Aadhaar=%s"
            cur = self.db.cursor()
            cur.execute(query, (VoterId, Aadhaar))
            if cur.fetchone()[0] == Password:
                print("Login successful!")
                self.after_login(Aadhaar)
                break
            else:
                print("Invalid password")
            leave = input("\nDo you want to leave?(YES/NO) ")
            if leave.upper() == "YES":
                print("Bye!!!")
                quit()
            print("\nPlease Try Again!\n")
    
    # Add other methods: after_login, vote, party_registration, update, add_candidate, etc.

if __name__ == "__main__":
    obj = VotingSystem()
    while True:
        print("Enter your choice:")
        print("1. Login")
        print("2. Sign Up")
        print("3. Party Registration")
        x = input()
        if x.lower() == "login" or x == "1":
            obj.login()
        elif x.lower() == "sign up" or x == "2":
            obj.sign_up()
        elif x.lower() == "party registration" or x == "3":
            obj.party_registration()
        else:
            print("Invalid choice. Please try again.")
