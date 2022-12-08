/*
1. DROP
2. CREATE
3. 



*/






-- DROP

DROP DATABASE IF EXISTS wypozyczalnia;
CREATE DATABASE wypozyczalnia;
USE wypozyczalnia;


-- CREATE

CREATE TABLE publisher (
    publisher_name VARCHAR(100) primary key not null    
);

CREATE TABLE book (
    book_id int primary key not null,
    book_title VARCHAR(100) not null,
    publisher_name VARCHAR(100) not null,
    author_id VARCHAR(255) not null,
    CONSTRAINT fk_publisher_name
    FOREIGN KEY (publisher_name)
    REFERENCES publisher(publisher_name) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_author_id
    FOREIGN key (author_id)
    REFERENCES author(author_id) on UPDATE CASCADE on DELETE RESTRICT
);

CREATE TABLE author (
    author_id int primary key not null,
    author_name VARCHAR(255) not null,
);

CREATE TABLE branch (
    branch_id int primary key not null,
    branch_addres VARCHAR(50) not null

);

CREATE TABLE book_copy(
    copy_id int primary key not null,
    book_id int not null,
    branch_id int not null,
    CONSTRAINT fk_book_id
    FOREIGN key (book_id)
    REFERENCES book(book_id) on UPDATE CASCADE on DELETE RESTRICT,
    CONSTRAINT fk_branch_id
    FOREIGN key (branch_id)
    REFERENCES branch(branch_id) on UPDATE CASCADE on DELETE REFERENCES
);

CREATE TABLE user (
    user_id int primary key not null auto_increment,
    first_name VARCHAR(255) not null,
    last_name VARCHAR(255) not null,
    card_number int not null,
    address VARCHAR(255) not null,
    phone_number int not null
);

CREATE TABLE loan(

);

CREATE TABLE librarian(

);



