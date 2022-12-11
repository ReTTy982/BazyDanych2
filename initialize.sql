/*
1. DROP
2. CREATE
3. VARS
4. VIEWS
5. TRIGGERS




*/






-- DROP

DROP DATABASE IF EXISTS wypozyczalnia;
CREATE DATABASE wypozyczalnia;
USE wypozyczalnia;


-- CREATE

CREATE TABLE publisher (
    PublisherName VARCHAR(100) primary key,
    PhoneNumber VARCHAR(30) unique not null   
);

CREATE TABLE author (
    AuthorID int primary key not null auto_increment,
    AuthorName VARCHAR(255) not null
);

CREATE TABLE book (
    BookID int primary key not null auto_increment,
    BookTitle VARCHAR(200) not null,
    PublisherName VARCHAR(100) not null,
    AuthorID int not null,
    Category VARCHAR(100) not null,
    CONSTRAINT fk_book_publisher
    FOREIGN KEY (PublisherName)
    REFERENCES publisher(PublisherName) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_book_author
    FOREIGN key (AuthorID)
    REFERENCES author(AuthorID) on UPDATE CASCADE on DELETE RESTRICT
);



CREATE TABLE branch (
    BranchID int primary key not null auto_increment,
    BranchAddress VARCHAR(50) not null

);

CREATE TABLE bookCopy (
    CopyID int primary key not null auto_increment,
    BookID int not null,
    BranchID int not null,
    CopyStatus varchar(30) not null default 'na stanie',
    CONSTRAINT fk_bookCopy_book
    FOREIGN key (BookID)
    REFERENCES book(BookID) on UPDATE CASCADE on DELETE RESTRICT,
    CONSTRAINT fk_bookCopy_branch
    FOREIGN key (BranchID)
    REFERENCES branch(BranchID) on UPDATE CASCADE on DELETE RESTRICT
);

CREATE TABLE user (
    UserID int primary key not null auto_increment,
    FirstName VARCHAR(255) not null,
    LastName VARCHAR(255) not null,
    CardNumber int not null unique,
    Login varchar(30) not null unique,
    Password varchar(30) not null, -- Dodac tutaj kodowanie 
    Address VARCHAR(255) not null,
    PhoneNumber VARCHAR(30) unique not null
);

CREATE TABLE librarian(
    LibrarianID int primary key auto_increment,
    Login varchar(20) not null,
    Password varchar(20) not null,
    BranchID int not null,
    FirstName VARCHAR(255) not null,
    LastName VARCHAR(255) not null,
    CONSTRAINT fk_librarian_branch
    FOREIGN KEY (BranchID)
    REFERENCES branch(BranchID) on UPDATE CASCADE on delete restrict
);

CREATE TABLE bookIssue(
    bookIssueID int primary key auto_increment,
    CopyID int not null unique,
    BranchID int,
    CardNumber int,
    DateIssue date not null,
    DateDue date not null,
    LibrarianID int,
    CONSTRAINT fk_bookIssue_bookCopy
    FOREIGN key (CopyID)
    REFERENCES bookCopy(CopyID) on UPDATE CASCADE on DELETE RESTRICT,
    CONSTRAINT fk_bookIssue_branch
    FOREIGN key (BranchID)
    REFERENCES branch(BranchID) on UPDATE CASCADE on DELETE RESTRICT,
    CONSTRAINT fk_bookIssue_user
    FOREIGN key (CardNumber)
    REFERENCES user(CardNumber) on DELETE RESTRICT,
    CONSTRAINT fk_bookIssue_librarian
    FOREIGN key (LibrarianID)
    REFERENCES librarian(LibrarianID)
);



-- VIEWS

-- Ksiazki w danym branchu
CREATE VIEW viewBooksInBranch AS 
SELECT bookCopy.CopyID, book.BookTitle, author.AuthorName, bookCopy.BranchID
FROM bookCopy
INNER JOIN book ON bookCopy.BookID=book.BookID
INNER JOIN author ON book.AuthorID=author.AuthorID;

-- Ilosc ksiazek w danym branchu
CREATE VIEW viewNumberOfBooksInBranch AS
SELECT bookCopy.BranchID, count(bookCopy.CopyID) as "Number of copies"
from bookCopy
group by bookCopy.BranchID;


-- Terminy oddania
CREATE VIEW viewDays as
SELECT user.CardNumber, bookIssue.DateIssue, bookIssue.DateDue, 
datediff(bookIssue.DateDue,bookIssue.DateIssue) as days,
IF(datediff(bookIssue.DateDue,bookIssue.DateIssue)<0,-(datediff(bookIssue.DateDue,bookIssue.DateIssue))*0.50,0) as payment
FROM bookIssue
INNER JOIN user on bookIssue.CardNumber=user.CardNumber;







-- TRIGGERS

CREATE TRIGGER tr_borrow
after insert ON bookIssue
FOR EACH ROW
UPDATE bookcopy
SET CopyStatus = 'wypozyczona'
WHERE bookCopy.CopyID = NEW.CopyID;

CREATE TRIGGER tr_return
after delete on bookIssue
for each ROW
update bookcopy
set CopyStatus = 'na stanie'
Where bookCopy.CopyID = old.CopyID;



