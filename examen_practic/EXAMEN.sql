create database examen_223
use examen_223
go
create table Tipuri(
id_tip int primary key identity(1,1),
denumire varchar(100),
descriere varchar(100),
)
create table Canale(
id_canal int primary key identity(1,1),
denumire varchar(100),
rating int,
)
create table Seriale(
id_seriale int primary key identity(1,1),
denumire varchar(100),
prezentare varchar(100),
nr int,
id_tip int ,
constraint fk_tipuri foreign key(id_tip)references Tipuri(id_tip),
id_canal int,
constraint fk_canal foreign key(id_canal)references Canale(id_canal),
)

create table Utilizator(
id_utilizator int primary key identity(1,1),
nume varchar(100),
prenume varchar(100),
gen varchar(100),
varsta int,
)
create table seriale_utilizatori(
id_seriale int ,
data_lansarii date,
ora_lansarii time,
constraint fk_seriale foreign key(id_seriale)references Seriale(id_seriale),
id_utilizator int,
constraint fk_util foreign key(id_utilizator)references Utilizator(id_utilizator),
constraint pk primary key (id_utilizator,id_seriale)
)

INSERT INTO Tipuri (denumire, descriere) VALUES 
('Tip1', 'Descriere Tip 1'),
('Tip2', 'Descriere Tip 2'),
('Tip3', 'Descriere Tip 3');

INSERT INTO Canale (denumire, rating) VALUES 
('Canal1', 5),
('Canal2', 4),
('Canal3', 3);
select*from Canale

update Canale set denumire ='Canal6' where id_canal=6

INSERT INTO Seriale (denumire, prezentare, nr, id_tip, id_canal) VALUES 
('Serial1', 'Prezentare Serial 1', 10, 1, 1),
('Serial2', 'Prezentare Serial 2', 12, 2, 2),
('Serial3', 'Prezentare Serial 3', 8, 3, 3);

INSERT INTO Utilizator (nume, prenume, gen, varsta) VALUES 
('Nume1', 'Prenume1', 'M', 25),
('Nume2', 'Prenume2', 'F', 30),
('Nume3', 'Prenume3', 'M', 22);


INSERT INTO seriale_utilizatori (id_seriale, data_lansarii, ora_lansarii, id_utilizator) VALUES 
(1, '2024-01-09', '12:30:00', 1),
(2, '2024-01-10', '15:45:00', 2),
(3, '2024-01-11', '18:00:00', 3);

go
create or alter procedure procedure1
@id_serial int,
@id_utilizator int,
@data_lansare date,
@ora_dif time
as
begin
if(exists(Select * from seriale_utilizatori where id_seriale=@id_serial and id_utilizator=@id_utilizator))
	begin
		update seriale_utilizatori set data_lansarii=@data_lansare,ora_lansarii=@ora_dif where id_seriale=@id_serial and id_utilizator=@id_utilizator
	end
else 
	begin
	insert into seriale_utilizatori(id_seriale,id_utilizator,data_lansarii,ora_lansarii) values(@id_serial,@id_utilizator,@data_lansare,@ora_dif)
	end 
end
go

SELECT * FROM Tipuri;

SELECT * FROM Canale;

SELECT * FROM Seriale;

SELECT * FROM Utilizator;

SELECT * FROM seriale_utilizatori;
exec procedure1 1,1,'2024-02-09','12:30:00'
exec procedure1 2,2, '2024-01-10', '15:46:00'
exec procedure1 3,3, '2024-03-11', '17:00:00'
exec procedure1 1,3, '2024-05-11', '18:30:00'
exec procedure1 3,1, '2024-02-17', '18:30:00'
exec procedure1 2,1, '2024-10-02', '20:30:00'
exec procedure1 2,3, '2024-04-02', '20:30:00'
exec procedure1 3,4, '2024-04-02', '20:30:00'
exec procedure1 3,5, '2024-04-02', '20:30:00'
exec procedure1 5,1, '2025-08-02', '20:30:00'
exec procedure1 5,5, '2024-04-03', '20:30:00'
exec procedure1 5,4, '2024-01-02', '22:00:00'
exec  procedure1 5,3, '2024-01-02', '22:00:00'
----de predat------
exec procedure1 5,2, '2024-01-02', '22:00:00'
go
create or alter view view_1
as
select s.denumire  from Seriale s 
inner join seriale_utilizatori su on su.id_seriale=s.id_seriale
inner join Utilizator u on u.id_utilizator=su.id_utilizator
group by s.denumire having count(su.id_utilizator)>=3
go 

SELECT * FROM Tipuri;
SELECT * FROM Canale;
SELECT * FROM Seriale;
SELECT * FROM Utilizator;
SELECT * FROM seriale_utilizatori;
select*from view_1
INSERT INTO Utilizator (nume, prenume, gen, varsta) VALUES 
('Nume4', 'Prenume4', 'F', 24),
('Nume5', 'Prenume5', 'B', 19)
INSERT INTO Seriale (denumire, prezentare, nr, id_tip, id_canal) VALUES 
('Serial4', 'Prezentare Serial 4', 10, 1, 1)
INSERT INTO Seriale (denumire, prezentare, nr, id_tip, id_canal) VALUES 
('Serial5', 'Prezentare Serial 5', 10, 2, 2)
