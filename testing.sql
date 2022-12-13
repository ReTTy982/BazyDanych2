SELECT * FROM wypozyczalnia.bookissue;
update bookissue
set librarianid = (select librarianid from librarian where branchid = 7 limit 1 )
where copyid = 1453;


select * from user
where LastName = 'Paczynski';

insert into user (FirstName, LastName, CardNumber, Login, Password, Address, PhoneNumber) 
values ('Paul', 'Paczynski', '123456789', 'polek', 'abcdefg', 'Inflancka 11', '111-111-1111');


select * from bookissue
where cardnumber = 123456789;

select * from bookcopy
where copystatus = 'na stanie';

INSERT INTO `wypozyczalnia`.`bookissue`
(
`CopyID`,
`BranchID`,
`CardNumber`,
`DateIssue`,
`DateDue`)
VALUES (1,(select branchid from branch where branchid = 1 limit 1), (select cardnumber from user where lastname = 'Paczynski'),'2022-12-13','2022-12-15');

delete from bookissue where bookissueid = 75;

select * from viewdays;
select * from viewbooksinbranch;
select * from viewnumberofbooksinbranch;

delete from user where lastname = 'Paczynski';
delete from bookissue where CopyID = 1;
select * from bookcopy where copyid = 1;

select * from bookcopy where CopyStatus = 'wypozyczona';



SET SQL_SAFE_UPDATES = 0;