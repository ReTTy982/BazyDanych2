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
    PhoneNumber VARCHAR(30)    
);

CREATE TABLE author (
    AuthorID int primary key not null auto_increment,
    AuthorName VARCHAR(255) not null
);

CREATE TABLE book (
    BookID int primary key not null,
    BookTitle VARCHAR(100) not null,
    PublisherName VARCHAR(100) not null,
    AuthorID int not null,
    CONSTRAINT fk_book_publisher
    FOREIGN KEY (PublisherName)
    REFERENCES publisher(PublisherName) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_book_author
    FOREIGN key (AuthorID)
    REFERENCES author(AuthorID) on UPDATE CASCADE on DELETE RESTRICT
);



CREATE TABLE branch (
    BranchID int primary key not null,
    BranchAddress VARCHAR(50) not null

);

CREATE TABLE bookCopy (
    CopyID int primary key not null,
    BookID int not null,
    BranchID int not null,
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
    PhoneNumber int not null
);

CREATE TABLE bookIssue(
    bookIssueID int primary key,
    CopyID int not null,
    BranchID int not null,
    CardNumber int not null,
    CONSTRAINT fk_bookIssue_bookCopy
    FOREIGN key (CopyID)
    REFERENCES bookCopy(CopyID) on UPDATE CASCADE on DELETE RESTRICT,
    CONSTRAINT fk_bookIssue_branch
    FOREIGN key (BranchID)
    REFERENCES branch(BranchID) on UPDATE CASCADE on DELETE RESTRICT,
    CONSTRAINT fk_bookIssue_user
    FOREIGN key (CardNumber)
    REFERENCES user(CardNumber) on DELETE RESTRICT
);

CREATE TABLE librarian(
    LibrarianID int primary key auto_increment,
    Login varchar(20) not null,
    Password varchar(20) not null,
    BranchID int not null,
    FirstName VARCHAR(255) not null,
    LastName VARCHAR(255) not null
);

-- VARS
SET @viewBooksInBranchVariable := 1;
-- VIEWS

CREATE VIEW viewBooksInBranch AS 
SELECT bookCopy.CopyID, book.BookTitle, author.AuthorName
FROM bookCopy
INNER JOIN book ON bookCopy.BookID=book.BookID
INNER JOIN author ON book.AuthorID=author.AuthorID;





-- TRIGGERS





