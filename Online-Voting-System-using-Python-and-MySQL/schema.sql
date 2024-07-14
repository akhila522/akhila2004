CREATE TABLE Address(
  DistrictID INTEGER NOT NULL,
  Locality VARCHAR(30) NOT NULL,
  City VARCHAR(30) NOT NULL,
  State VARCHAR(30) NOT NULL,
  Pincode VARCHAR(10) NOT NULL,
  CONSTRAINT PK_District PRIMARY KEY (DistrictID)
);

CREATE TABLE Voter_Table(
  AADHAAR CHAR(15) NOT NULL UNIQUE,
  FirstName VARCHAR(30) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  MotherName VARCHAR(30),
  FatherName VARCHAR(30),
  Sex CHAR(10) NOT NULL,
  Birthday DATE NOT NULL,
  Age INT NOT NULL,
  DistrictID INTEGER NOT NULL,
  Phone NUMERIC NOT NULL,
  CONSTRAINT PK_VOTER PRIMARY KEY (AADHAAR),
  CONSTRAINT FK_DISTRICT FOREIGN KEY (DistrictID) REFERENCES Address(DistrictID)
);

CREATE TABLE Candidate_Type(
  CandidateTypeID INT NOT NULL,
  CandidateType VARCHAR(20) NOT NULL,
  CONSTRAINT PK_CANDIDATETYPE PRIMARY KEY (CandidateTypeID)
);

CREATE TABLE Election_Table(
  ElectionID INT NOT NULL,
  ElectionType VARCHAR(20) NOT NULL,
  CONSTRAINT PK_ELECTION PRIMARY KEY (ElectionID)
);

CREATE TABLE Party_Table(
  PartyID INT NOT NULL,
  PartyName VARCHAR(20) NOT NULL UNIQUE,
  Symbol VARCHAR(20) NOT NULL UNIQUE,
  PartyLeader VARCHAR(50) NOT NULL,
  CONSTRAINT PK_PARTY PRIMARY KEY (PartyID)
);

CREATE TABLE User_Type(
  UserTypeID INT NOT NULL,
  UserType VARCHAR(20) NOT NULL,
  CONSTRAINT PK_USERTYPE PRIMARY KEY (UserTypeID)
);

CREATE TABLE Candidate_Table(
  CandidateID INT NOT NULL,
  AADHAAR CHAR(15) NOT NULL,
  CandidateTypeID INT NOT NULL,
  PartyID INT NOT NULL,
  ElectionID INT NOT NULL,
  DistrictID INT NOT NULL,
  CONSTRAINT PK_CANDIDATE PRIMARY KEY (CandidateID),
  CONSTRAINT FK_VOTER FOREIGN KEY (AADHAAR) REFERENCES Voter_Table(AADHAAR),
  CONSTRAINT FK_DISTRICT_2 FOREIGN KEY (DistrictID) REFERENCES Address(DistrictID),
  CONSTRAINT FK_ELECTION FOREIGN KEY (ElectionID) REFERENCES Election_Table(ElectionID),
  CONSTRAINT FK_PARTY FOREIGN KEY (PARTYID) REFERENCES Party_Table(PartyID),
  CONSTRAINT FK_CANDIDATETYPE FOREIGN KEY (CandidateTypeID) REFERENCES Candidate_Type(CandidateTypeID)
);

CREATE TABLE User_Table(
  VoterID VARCHAR(10) NOT NULL,
  Def_Password VARCHAR(50) NOT NULL,
  isActive BOOLEAN NOT NULL,
  AADHAAR CHAR(15) NOT NULL,
  UserTypeID INT NOT NULL,
  CONSTRAINT PK_USER PRIMARY KEY (VoterID),
  CONSTRAINT FK_VOTER_2 FOREIGN KEY (AADHAAR) REFERENCES Voter_Table(AADHAAR),
  CONSTRAINT FK_USERID FOREIGN KEY (UserTypeID) REFERENCES User_Type(UserTypeID)
);

CREATE TABLE Vote_Table(
  VoteID VARCHAR(7) NOT NULL,
  VoterID VARCHAR(10) NOT NULL UNIQUE,
  PartyID INT NOT NULL,
  CandidateID INT NOT NULL,
  DistrictID INT NOT NULL,
  Def_Password VARCHAR(50) NOT NULL,
  password_entered VARCHAR(50) NOT NULL,
  CONSTRAINT PK_VOTE PRIMARY KEY (VoteID),
  CONSTRAINT FK_VOTERID FOREIGN KEY (VoterID) REFERENCES User_Table(VoterID),
  CONSTRAINT FK_CANDIDATEID FOREIGN KEY (CandidateID) REFERENCES Candidate_Table(CandidateID),
  CONSTRAINT FK_DISTRICT_4 FOREIGN KEY (DistrictID) REFERENCES Address(DistrictID),
  CONSTRAINT FK_PARTY_2 FOREIGN KEY (PARTYID) REFERENCES Party_Table(PartyID),
  CHECK (Def_password=password_entered)
);

CREATE TABLE Result(
  ResultID INT NOT NULL AUTO_INCREMENT,
  CandidateID INT NOT NULL,
  PartyID INT NOT NULL,
  DistrictID INT NOT NULL,
  Vote_Count INT NOT NULL,
  CONSTRAINT PK_RESULT PRIMARY KEY (ResultID),
  CONSTRAINT FK_CANDIDATEID_2 FOREIGN KEY (CandidateID) REFERENCES Candidate_Table(CandidateID),
  CONSTRAINT FK_DISTRICT_5 FOREIGN KEY (DistrictID) REFERENCES Address(DistrictID),
  CONSTRAINT FK_PARTY_3 FOREIGN KEY (PARTYID) REFERENCES Party_Table(PartyID)
);
INSERT INTO Candidate_Type VALUES (100, "MP");
INSERT INTO Candidate_Type VALUES (101, "MLA");

INSERT INTO User_Type VALUES (1, "Candidate");
INSERT INTO User_Type VALUES (2, "Citizen");

INSERT INTO Party_Table VALUES (11, "BJP", "Lotus", "Narendra Modi");
INSERT INTO Party_Table VALUES (12, "INC", "Hand", "Rahul Gandhi");
INSERT INTO Party_Table VALUES (13, "AAP", "Broom", "Arvind Kejriwal");
INSERT INTO Party_Table VALUES (14, "BSP", "Elephant", "Mayawati");

INSERT INTO Election_Table VALUES (200, "General Elections");
INSERT INTO Election_Table VALUES (201, "State Assembly");

INSERT INTO Address VALUES (234, "Andheri", "Mumbai", "Maharashtra", "400059");
INSERT INTO Address VALUES (235, "Hadapsar", "Pune", "Maharashtra", "411013");
INSERT INTO Address VALUES (236, "Malviya", "Lucknow", "Uttar Pradesh", "226004");
INSERT INTO Address VALUES (237, "Depalpur", "Indore", "Madhya Pradesh", "453115");

INSERT INTO Voter_Table VALUES ("3591 4628 3661", "Akash", "Singh", "Aishwarya", "Bhavesh", "M", "1984-02-16", 37, 234, "9623412913");
INSERT INTO Voter_Table VALUES ("5773 7940 7366", "Dipti", "Kumar", "Gayatri", "Dheeraj", "F", "1998-01-13", 23, 235, "9222325956");
INSERT INTO Voter_Table VALUES ("7820 3429 4038", "Shlok", "Agarwal", "Aparna", "Girish", "M", "1988-02-04", 33, 234, "9722768470");
INSERT INTO Voter_Table VALUES ("6169 5028 5641", "Rashid", "Khan", "Indira", "Abhay", "M", "1976-10-17", 44, 235, "9414321457");
INSERT INTO Voter_Table VALUES ("7367 4166 6818", "Nicole", "Dias", "Juhi", "Deepak", "F", "1991-12-08", 29, 234, "9913542379");
INSERT INTO Voter_Table VALUES ("5698 6323 9187", "Muskan", "Gupta", "Latika", "Harmeet", "F", "1990-07-14", 30, 235, "9406269045");
INSERT INTO Voter_Table VALUES ("3552 8455 9830", "Saima", "Shaikh", "Anushree", "Bipin", "F", "1975-12-02", 45, 234, "9251125952");
INSERT INTO Voter_Table VALUES ("4616 8141 8774", "Mayur", "Chauhan", "Mallika", "Mahendra", "M", "1998-06-01", 22, 235, "9445560413");
INSERT INTO Voter_Table VALUES ("5629 4547 8360", "Aniket", "Mali", "Namrata", "Aditya", "M", "1977-08-30", 43, 234, "9353628848");
INSERT INTO Voter_Table VALUES ("9159 9075 6877", "Priti", "Krishna", "Niharika", "Rakesh", "F", "1984-02-03", 37, 235, "9357732303");
INSERT INTO Voter_Table VALUES ("9996 7085 3995", "Bhavna", "Wadhwani", "Arpita", "Mehul", "F", "1986-05-18", 34, 234, "9600223943");
INSERT INTO Voter_Table VALUES ("3904 9051 4118", "Shrishti", "Kulkarni", "Devina", "Chiranjeev", "F", "1977-08-21", 43, 235, "9226511275");
INSERT INTO Voter_Table VALUES ("6675 3767 7127", "Manav", "Singh", "Saanvi", "Rahil", "M", "1993-11-13", 27, 234, "9355763904");
INSERT INTO Voter_Table VALUES ("9934 5143 4853", "Vikram", "Shah", "Swara", "Sushant", "M", "1974-06-04", 46, 235, "9110402260");
INSERT INTO Voter_Table VALUES ("4025 6886 5147", "Poonam", "Shah", "Tara", "Sushant", "F", "1998-09-02", 22, 234, "9602393586");
INSERT INTO Voter_Table VALUES ("6044 5246 7887", "Priya", "Mishra", "Radha", "Arjun", "F", "1995-04-08", 25, 235, "9218216230");
