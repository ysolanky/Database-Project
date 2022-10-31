# DB Design project
SET GLOBAL FOREIGN_KEY_CHECKS=0;

# CREATE TABLES 

Create table Team (
TeamID VARCHAR(5), 
TeamPoints int, 
TeamName VARCHAR(20), 
Budget int, 
NoOfPlayers INT, 
Stadium VARCHAR(25),
primary key(TeamID)
);

Create table Player (
PlayerID char(5), 
PlayerFname VARCHAR(25), 
PlayerLName VARCHAR(25), 
Gender VARCHAR(10), 
DateofBirth DATE, 
Salary double, 
Bonus int, 
NoOfMatchesPlayed int, 
TeamID VARCHAR(5),
primary key (PlayerID),
Foreign key(TeamID) REFERENCES Team(teamID) on delete cascade
);

CREATE TABLE playerpos (
	PlayerPosition char(3) NOT NULL,
    PlayerID char(5) NOT NULL,
    CONSTRAINT PK_playerpos primary key ( PlayerPosition, PlayerID ),
    FOREIGN KEY(PlayerID) REFERENCES Player(PlayerID) on DELETE CASCADE
);

CREATE TABLE Tournament (
	TournamentID char(2) NOT NULL,
    TournamentName varchar(20) NOT NULL,
    TournamentType varchar(10) NOT NULL,
    TournamentCountry varchar(20) NOT NULL,
    TournamentDivision int,
    NumberOfTeams int NOT NULL,
    primary key(TournamentID)
);

CREATE TABLE ConsistsOf (
	TeamID varchar(5) NOT NULL,
    TournamentID char(2) NOT NULL,
    CONSTRAINT PK_consistsof primary key ( TeamID, TournamentID ),
    Foreign key(TeamID) REFERENCES Team(teamID) on delete cascade,
    Foreign key(TournamentID) REFERENCES Tournament(TournamentID) on delete cascade
);

CREATE TABLE MatchOfficial (
	OfficialID varchar(10) NOT NULL,
    TournamentID char(2) NOT NULL,
    OfficialName varchar(50) NOT NULL,
    OfficialCountry varchar(50) NOT NULL,
    OfficialAge int NOT NULL,
    OfficialExperience int NOT NULL,
    CONSTRAINT PK_matchofficial primary key ( OfficialID, TournamentID ),
	Foreign key(TournamentID) REFERENCES Tournament(TournamentID) on delete cascade
);

CREATE TABLE Staff (
	StaffID varchar(10) NOT NULL,
    StaffName varchar(50) NOT NULL,
    StaffAge int NOT NULL,
    PRIMARY KEY (StaffID)
);

CREATE TABLE Medical (
	StaffID varchar(10) NOT NULL,
	Name varchar(50) NOT NULL,
    Age varchar (50) NOT NULL,
    Type varchar(10) NOT NULL,
    PRIMARY KEY (StaffID),
    FOREIGN KEY (StaffID) REFERENCES Staff (StaffID)
);

CREATE TABLE Coaching (
	StaffID varchar(10) NOT NULL,
	Name varchar(50) NOT NULL,
    Age varchar (50) NOT NULL,
    Type varchar(10) NOT NULL,
	FOREIGN KEY (StaffID) REFERENCES Staff (StaffID)
);


CREATE TABLE Sponsor (
	SponsorID varchar(10) NOT NULL,
    SponsorName varchar(20) NOT NULL,
    SponsorType varchar(30) NOT NULL,
    SponsorFunding int NOT NULL,
    primary key(SponsorID)
);

CREATE TABLE Funds (
	SponsorID varchar(10) NOT NULL,
    TeamID varchar(5) NOT NULL,
    primary key ( SponsorID, TeamID ),
    Foreign key(SponsorID) REFERENCES Sponsor(SponsorID) on update cascade on delete cascade,
    Foreign key(TeamID) REFERENCES Team(teamID) on update cascade on delete restrict
);

drop table Funds;

CREATE TABLE Has (
	SponsorID varchar(10) NOT NULL,
    TournamentID char(2) NOT NULL,
    CONSTRAINT PK_has primary key ( SponsorID, TournamentID ),
    Foreign key(SponsorID) REFERENCES Sponsor(SponsorID) on delete cascade,
    Foreign key(TournamentID) REFERENCES Tournament(TournamentID) on delete cascade
);

CREATE TABLE Employs (
	TeamID varchar(5) NOT NULL,
	StaffID varchar(10) NOT NULL,
    EmployeeType varchar(10) NOT NULL,
    CONSTRAINT PK_employs primary key ( TeamID, StaffID ),
    Foreign key(TeamID) REFERENCES Team(teamID) on update cascade on delete restrict,
    FOREIGN KEY (StaffID) REFERENCES Staff (StaffID)
);

# POPULATING THE DATABASE

insert into Team values
(00001, 100, 'Manchester City', 1000000, 40, 'Etihad' ),
(00002, 25, 'Manchester United', 50000, 12, 'Old Trafford' ),
(00003, 99, 'Liverpool', 500000, 20, 'Anfield'),
(00004, 60, 'Chelsea', 5500000, 25, 'Stamford Bridge'),
(00005, 50, 'Aresnal', 540000, 27, 'Emirates');

insert into player VALUES
('PO007', 'Cristiano', 'Ronaldo', 'Male', '1985-02-05', 500000, 800000, 50, 00002),
('BL001', 'Kevin', 'Debruyne', 'Male', '1991-06-25', 300000, 50000, 45, 00001),
('EG011', 'Mo', 'Salah', 'Male', '1985-07-23', 350000, 20000, 42, 00003),
('GE007', 'Kai', 'Havertz', 'Male', '1999-11-06', 150000, NULL, 18, 00004),
('NO007', 'Martin', 'Odegaard', 'Male', '1998-12-22', 100000, NULL, 15, 00005);

INSERT INTO PLAYERPOS VALUES
("ST","PO007"),("RW","BL001"),("LW","EG011"),("MID","GE007"),("CAM","NO007");

INSERT INTO TOURNAMENT VALUES
("A1","Champions League", "League","Europe",10,"24"),
("A2","La liga", "League","Spain",1,"20"),
("A3","Premier League", "League","England",1,"20"),
("A4","Bundesliga", "League","Germany",1,"20"),
("A5","Ligue 1", "League","France",1,"20");

INSERT INTO CONSISTSOF VALUES
(1,"A1"),(2,"A2"),(3,"A3"),(4,"A4"),(5,"A5");

INSERT INTO STAFF VALUES
("C1","Carlo",62),
("C2","Pep",50),
("C3","Jose",55),
("C4","Zidane",5),
("C5","Rafa",68);


INSERT INTO MATCHOFFICIAL VALUES 
("R01","A1","Marcelo","Brazil",32,12),
("R02","A2","Vini Jr","Brazil",21,0),
("R03","A3","Mendy","France",32,8),
("R04","A4","Benzema","France",33,6),
("R05","A5","Bale","Wales",35,5);

INSERT INTO SPONSOR VALUES
("S01","Heineken","Commercial advertistment",100000),
("S02","Fly emirates","Kit sponsor",1000000),
("S03","Team Viewer","Kit sponsor",500000),
("S04","Mahau","Commercial advertistment",250000),
("S05","Hyatt","Travel",10000);

INSERT INTO EMPLOYS VALUES 
(1,"C1","A"),(2,"C2","B"),(3,"C3","B"),(4,"C4","A"),(5,"C5","C");

INSERT INTO FUNDS VALUES
("S01",1),("S02",2),("S03",3),("S04",4),("S05",5);

INSERT INTO MEDICAL VALUES
("C1","James",22,"M"),
("C2","Modric",25,"M"),
("C3","Kroos",30,"M"),
("C4","Casemiro",32,"M"),
("C5","Dani",22,"M");

INSERT INTO Coaching VALUES
("C1","Isco",22,"C"),
("C2","Rakitic",27,"C"),
("C3","Iniesta",29,"C"),
("C4","Debruyne",22,"C"),
("C5","Neymar",20,"C");

INSERT INTO HAS VALUES
("S01","A1"),
("S02","A2"),
("S03","A3"),
("S04","A4"),
("S05","A5");


# QUERIES:

# Query 1
select t.teamname, t.budget, s.sponsorname, s.sponsorfunding
from team t natural join sponsor s;

# Query 2
SELECT TeamID, TournamentID
FROM ConsistsOf
WHERE TeamID IN (SELECT TeamID
					FROM Team
					WHERE Budget >= 540000);
                    
# Query 3:
select t.teamid, t.teamname, t.Noofplayers, e.employeetype, s.staffname
from team t natural join employs e natural join staff s
where s.staffage > 18;

# Query 4:
SELECT m.OfficialID, m.OfficialName, m.TournamentID, t.TournamentName
FROM MatchOfficial m
NATURAL JOIN Tournament t
WHERE m.OfficialExperience >= 5 AND t.TournamentDivision = 1;

# Query 5:
SELECT * 
FROM Medical 
UNION
SELECT *
FROM Coaching; 

# Query 6:
select m.officialId, m.officialname, m.officialCountry
from tournament t
natural join matchofficial m
where m.officialExperience > 5;

# Query 7
SELECT DISTINCT p.playerfname, p.playerlname, p.dateofbirth, p.salary, p.noofmatchesplayed, team.teamname 
from player p  
inner join team on p.TeaMid = TEAM.TEAMid
where p.noofmatchesplayed < 20
group by p.playerfname, p.playerlname, p.dateofbirth, p.salary, p.noofmatchesplayed, team.teamname
having p.salary > avg(p.salary);

# Query 8
SELECT SponsorID, TournamentID
FROM Has
WHERE TournamentID IN (SELECT TournamentID
						FROM Tournament
                        WHERE NumberOfTeams >= 15)
AND SponsorID IN (SELECT SPONSORID 
					FROM SPONSOR
                    WHERE SponsorFunding >= 500000);

# Query 9:
select p.playerFname, p.playerLname, p.Noofmatchesplayed, ps.playerposition
from player p 
join playerpos ps on ps.playerid = p.playerid
where exists (select 1 
				from team t 
				where t.teamid = p.teamid and t.noofplayers > 20 and t.teamid in (select teamid 
																					from employs 
																					where employeetype = 'C'));
                                                                                    
# Query 10:
select p.PlayerFName, p.PlayerLName, p.Gender,te.TeamID, te.TeamName, tou.TournamentID, tou.TournamentName
from team te
natural join tournament tou
natural join player p 
where te.TeamPoints >= 60
and tou.TournamentCountry = "England";