--Script tabele Licenta----------------------------------------------------------------------------------------------------------

/* Cuprins:
	   1.  CINEMA.MOVIE
	   2.  CINEMA.MOVIE_RATING
	   3.  CINEMA.MOVIE_GENRE
	   4.  CINEMA.RESERVATION_SEATS
	   5.  CINEMA.THEATRE
	   6.  CINEMA.SEAT
	   7.  CINEMA.RESERVATION
	   8.  CINEMA.SCHEDULE*/

---------------------------------------------------------------------------------------------------------------------------------

use Cinema12;
go

alter database Cinema12 set allow_snapshot_isolation on

---------------------------------------------------------------------------------------------------------------------------------

if SCHEMA_ID('CINEMA') is null exec('create schema CINEMA');
go

--1. CINEMA.MOVIE----------------------------------------------------------------------------------------------------------------

/* Tabel ce curpinde filmele:
	- MovieId		-> Id-ul filmului.
	- Title			-> Titlul filmului.
	- Duration		-> Durata filmului.
	- Genre			-> Genul filmului.
	- Rating		-> Audienta target.
	- Distribution	-> Distributia filmului.
	- Description	-> Descrierea filmului.
	- Poster		-> Posterul stocat in hexa.
	- Trailer		-> Trailer-ul filmului.
	- StartDate		-> Data de la care se difuzeaza filmul.
	- EndDate		-> Data de sfarsit a difuzarii filmului. */

if OBJECT_ID('CINEMA.MOVIE') is not null drop table CINEMA.MOVIE
go

create table CINEMA.MOVIE(
	MovieId			int identity(1,1) primary key,
	Title			varchar(100),
	Duration		int,
	Genre			int foreign key references CINEMA.MOVIE_GENRE(MovieGenreId),
	Rating   		int foreign key references CINEMA.MOVIE_RATING(MovieRatingId),
	Distribution	varchar(255),
	Description		varchar(max),
	Poster			varbinary(max) not null,
	Trailer			varchar(255),
	StartDate		date default GETDATE(),
	EndDate			date);

go

select * from CINEMA.MOVIE


--2. CINEMA.MOVIE_RATING---------------------------------------------------------------------------------------------------------

/* Tabel cu tipurile de rating:
	- MovieRatingId   -> Id-ul rating-ului.
	- Name			  -> Numele rating-ului.
	- Acronym		  -> Acronimul rating-ului.
	- Description     -> Descrierea rating-ului.*/

if OBJECT_ID('CINEMA.MOVIE_RATING') is not null drop table CINEMA.MOVIE_RATING
go

create table CINEMA.MOVIE_RATING(
	MovieRatingId	int identity(1,1) primary key,
	Name			varchar(50),
	Acronym			varchar(5),
	Description		varchar(255));

go

--3. CINEMA.MOVIE_GENRE----------------------------------------------------------------------------------------------------------

/* Tabel cu tipurile de filme:
	- MovieGenreId  -> Id-ul genului.
	- Name			-> Numele genului de film.*/

if OBJECT_ID('CINEMA.MOVIE_GENRE') is not null drop table CINEMA.MOVIE_GENRE
go

create table CINEMA.MOVIE_GENRE(
	MovieGenreId	int identity(1,1) primary key,
	Name			varchar(50));

go

--4. CINEMA.RESERVATION_SEATS----------------------------------------------------------------------------------------------------

/* Tabela de legatura intre CINEMA.RESERVATION si CINEMA.SEAT:
	- ReservationSeatsId  -> Id-ul tabelului.
	- ReservationId		  -> Id-ul rezervarii din CINEMA.RESERVATION.
	- SeatId			  -> Id-ul scaunului din CINEMA.SEAT.*/

if OBJECT_ID('CINEMA.RESERVATION_SEATS') is not null drop table CINEMA.RESERVATION_SEATS
go

create table CINEMA.RESERVATION_SEATS(
	ReservationId		int references CINEMA.RESERVATION(ReservationId) not null,
	SeatId				int references CINEMA.SEAT(SeatId) not null,
	primary key (ReservationId, SeatId));	

go

create table CINEMA.RESERVATION_SEATS(
	ReservationSeatsId	int identity(1,1) primary key,
	ReservationId		int foreign key references CINEMA.RESERVATION(ReservationId),
	SeatId				int foreign key references CINEMA.SEAT(SeatId));	

go

--5. CINEMA.THEATRE--------------------------------------------------------------------------------------------------------------

/* Tabel cu salile filmelor:
	- TheatreId  -> Id-ul salii.
	- Name	     -> Numele salii.*/
	 
if OBJECT_ID('CINEMA.THEATRE') is not null drop table CINEMA.THEATRE
go

create table CINEMA.THEATRE(
	TheatreId	int identity(1,1) primary key,
	Name	    varchar(100));	

go

--6. CINEMA.SEAT-----------------------------------------------------------------------------------------------------------------

/* Tabel cu locurile din sala de cinema:
	- SeatId		 -> Id-ul scaunului.
	- RowLetter	     -> Randul (A-J).
	- SeatNumber	 -> Numarul scaunului (1-10).*/

if OBJECT_ID('CINEMA.SEAT') is not null drop table CINEMA.SEAT
go

create table CINEMA.SEAT(
	SeatId		int identity(1,1) primary key,
	RowLetter   varchar(1),
	SeatNumber  int);	

go

--7. CINEMA.RESERVATION----------------------------------------------------------------------------------------------------------

/* Tabel cu rezervarile pentru film:
	- ReservationId	 -> Id-ul rezervarii.
	- ScheduleId	 -> Id-ul orarului.
	- Name			 -> Numele persoanei care face rezervarea.
	- Telephone	     -> Numarul de telefon al persoanei care face rezervarea.
	- NoOfSeats		 -> Numarul de locuri rezervate.*/

if OBJECT_ID('CINEMA.RESERVATION') is not null drop table CINEMA.RESERVATION
go

create table CINEMA.RESERVATION(
	ReservationId  int identity(1,1) primary key,
	ScheduleId	   int foreign key references CINEMA.SCHEDULE(ScheduleId),
	Name		   varchar(255),
	Telephone	   varchar(20),
	NoOfSeats	   int);	

go

--8. CINEMA.SCHEDULE-------------------------------------------------------------------------------------------------------------

/* Tabel cu biletele pentru un film:
	- ScheduleId	-> Id-ul biletului.
	- TheatreId		-> Id-ul salii din CINEMA.THEATRE.
	- MovieId		-> Id-ul filmului din CINEMA.MOVIE.
	- TicketsLeft	-> Numarul de bilete ramase.
	- FromDate		-> Ora de incepere. 
	- ToDate        -> Ora de final.*/

if OBJECT_ID('CINEMA.SCHEDULE') is not null drop table CINEMA.SCHEDULE
go

create table CINEMA.SCHEDULE(
	ScheduleId	  int identity(1,1) primary key,
	TheatreId     int foreign key references CINEMA.THEATRE(TheatreId),
	MovieId		  int foreign key references CINEMA.MOVIE(MovieId),
	TicketsLeft	  int,
	FromDate      datetime,
	ToDate		  datetime);	

go

---------------------------------------------------------------------------------------------------------------------------------