--Script proceduri Licenta-------------------------------------------------------------------------------------------------------

/* Cuprins: 
	    1.  CINEMA.GetMovies
	    2.  CINEMA.GetPoster
		3.	CINEMA.GetMovieEntry
		4.  CINEMA.GetMovieRatings
		5.  CINEMA.GetMovieGenres
		6.	CINEMA.SaveMovie
		7.	CINEMA.DeleteMovie
		8.  CINEMA.GetMovieSchedule
		9.  CINEMA.GetScheduleEntry
		10. CINEMA.DeleteSchedule
		11. CINEMA.SaveSchedule
		12. CINEMA.GetTheatreName
		13. CINEMA.SaveReservation
		14. CINEMA.GetReservationsList
		15.	CINEMA.DeleteReservation
		16. CINEMA.GetReservedSeats
		17. CINEMA.GetSeatsList
		18. CINEMA.ReadUncommitted
		19. CINEMA.ReadCommitted
		20. CINEMA.RepeatableRead
		21. CINEMA.Snapshot
		22. CINEMA.Serializable
		23. CINEMA.IsAdmin
		24. CINEMA.CreateUser*/
		
---------------------------------------------------------------------------------------------------------------------------------

use Cinema12;
go

--roluri
create role ADMIN_ROLE
create role PUBLIC_ROLE
create user anonymous_access with password ='1234'

--1.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce toate filmele din tabela CINEMA.MOVIE.

	- Parametri: n/a.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetMovies') is not null drop proc CINEMA.GetMovies
go

create proc CINEMA.GetMovies

as set nocount on

select * from CINEMA.MOVIE order by Title;
go

grant exec on CINEMA.GetMovies to ADMIN_ROLE
go

grant exec on CINEMA.GetMovies to PUBLIC_ROLE
go

--2.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce posterul in functie de parametrul MovieId.

	- Parametri: MovieId.

	- Output: Poster. */

if OBJECT_ID('CINEMA.GetPoster') is not null drop proc CINEMA.GetPoster
go

create proc CINEMA.GetPoster
	@MovieId	int
as set nocount on

select Poster from CINEMA.MOVIE where MovieId = @MovieId
go

grant exec on CINEMA.GetPoster to ADMIN_ROLE
go

grant exec on CINEMA.GetPoster to PUBLIC_ROLE
go

--3.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce o inregistrare din CINEMA.MOVIE in funcite de MovieId.

	- Parametri: MovieId.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetMovieEntry') is not null drop proc CINEMA.GetMovieEntry
go

create proc CINEMA.GetMovieEntry
	@MovieId	int
as set nocount on

select MovieId, Title, Duration, Genre, Rating, Distribution, Description, Poster, Trailer, StartDate, EndDate from CINEMA.MOVIE where MovieId = @MovieId;
go

grant exec on CINEMA.GetMovieEntry to ADMIN_ROLE
go

grant exec on CINEMA.GetMovieEntry to PUBLIC_ROLE
go

--4.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce toate tipurile de rating din tabela CINEMA.MOVIE_RATING.

	- Parametri: n/a.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetMovieRatings') is not null drop proc CINEMA.GetMovieRatings
go

create proc CINEMA.GetMovieRatings

as set nocount on

select * from CINEMA.MOVIE_RATING;
go

grant exec on CINEMA.GetMovieRatings to ADMIN_ROLE
go

grant exec on CINEMA.GetMovieRatings to PUBLIC_ROLE
go

--5.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce toate tipurile de filme din tabela CINEMA.MOVIE_GENRES.

	- Parametri: n/a.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetMovieGenres') is not null drop proc CINEMA.GetMovieGenres
go

create proc CINEMA.GetMovieGenres

as set nocount on

select * from CINEMA.MOVIE_GENRE;
go

grant exec on CINEMA.GetMovieGenres to ADMIN_ROLE
go

grant exec on CINEMA.GetMovieGenres to PUBLIC_ROLE
go

--6.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Face update, daca nu exista, se introduce o noua inregistrare in CINEMA.MOVIE.

	- Parametri:  MovieId, Title, Duration, Genre, Rating, Distribution, Description, Poster.

	- Output: n/a. */

if OBJECT_ID('CINEMA.SaveMovie') is not null drop proc CINEMA.SaveMovie
go

create proc CINEMA.SaveMovie
	@MovieId		int,
	@Title			varchar(100),
	@Duration		int,
	@Genre			int,
	@Rating   		int,
	@Distribution	varchar(255),
	@Description	varchar(max),
	@Poster			varbinary(max),
	@Trailer		varchar(255),
	@StartDate		date,
	@EndDate		date
as set nocount on

update CINEMA.MOVIE set Title = @Title, Duration = @Duration, Genre = @Genre, Rating = @Rating, Distribution = @Distribution, Description = @Description, Poster = @Poster, Trailer = @Trailer, StartDate = @StartDate, EndDate = @EndDate 
	where MovieId = @MovieId;
if (@@ROWCOUNT = 0)
insert into CINEMA.MOVIE(Title, Duration, Genre, Rating, Distribution, Description, Poster, Trailer, StartDate, EndDate)  
select @Title, @Duration, @Genre, @Rating, @Distribution, @Description, @Poster, @Trailer, @StartDate, @EndDate;
go

grant exec on CINEMA.SaveMovie to ADMIN_ROLE
go
--7.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Sterge intregistrarea din CINEMA.MOVIE cu id-ul primit ca parametru.

	- Parametri:  MovieId.

	- Output: n/a. */

if OBJECT_ID('CINEMA.DeleteMovie') is not null drop proc CINEMA.DeleteMovie 
go

create proc CINEMA.DeleteMovie
	@MovieId	int
as set nocount on

delete from CINEMA.MOVIE where MovieId = @MovieId;

go

grant exec on CINEMA.DeleteMovie to ADMIN_ROLE
go

--8.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce toate programarile din tabela CINEMA.SCHEDULE pentru un film.

	- Parametri: MovieId.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetMovieSchedule') is not null drop proc CINEMA.GetMovieSchedule
go

create proc CINEMA.GetMovieSchedule
		@MovieId	int
as set nocount on

select a.ScheduleId, a.TheatreId, c.Name TheatreName, b.MovieId, b.Title MovieName, b.StartDate, b.EndDate, a.TicketsLeft, a.FromDate, a.ToDate 
	   from CINEMA.SCHEDULE a 
	   inner join CINEMA.MOVIE b on a.MovieId = b.MovieId
	   inner join CINEMA.THEATRE c on a.TheatreId = c.TheatreId 
	   where a.MovieId = @MovieId order by FromDate;
go

grant exec on CINEMA.GetMovieSchedule to ADMIN_ROLE
go

grant exec on CINEMA.GetMovieSchedule to PUBLIC_ROLE
go

--9.-----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce o inregistrare din CINEMA.SCHEDULE in funcite de ScheduleId.

	- Parametri: ScheduleId.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetScheduleEntry') is not null drop proc CINEMA.GetScheduleEntry
go

create proc CINEMA.GetScheduleEntry
	@ScheduleId	int
as set nocount on

select a.ScheduleId, a.TheatreId, c.Name TheatreName, b.MovieId, b.Title MovieName, b.StartDate, b.EndDate, a.TicketsLeft, a.FromDate, a.ToDate 
	   from CINEMA.SCHEDULE a 
	   inner join CINEMA.MOVIE b on a.MovieId = b.MovieId
	   inner join CINEMA.THEATRE c on a.TheatreId = c.TheatreId 
	   where a.ScheduleId = @ScheduleId;
go

grant exec on CINEMA.GetScheduleEntry to ADMIN_ROLE
go

--10.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Sterge intregistrarea din CINEMA.SCHEDULE cu id-ul primit ca parametru.

	- Parametri:  ScheduleId.

	- Output: n/a. */

if OBJECT_ID('CINEMA.DeleteSchedule') is not null drop proc CINEMA.DeleteSchedule 
go

create proc CINEMA.DeleteSchedule
	@ScheduleId	int
as set nocount on

delete from CINEMA.SCHEDULE where ScheduleId = @ScheduleId;

go

grant exec on CINEMA.DeleteSchedule to ADMIN_ROLE
go

--11.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Face update, daca nu exista, se introduce o noua inregistrare in CINEMA.SCHEDULE.

	- Parametri:  MovieId, Title, Duration, Genre, Rating, Distribution, Description, Poster.

	- Output: n/a. */

if OBJECT_ID('CINEMA.SaveSchedule') is not null drop proc CINEMA.SaveSchedule
go

create proc CINEMA.SaveSchedule
	@ScheduleId		int,
	@TheatreId		int,
	@MovieId		int,
	@TicketsLeft	int,
	@FromDate 		datetime,
	@ToDate			datetime
as set nocount on

update CINEMA.SCHEDULE set TheatreId = @TheatreId, MovieId = @MovieId, TicketsLeft = @TicketsLeft, FromDate = @FromDate, ToDate = @ToDate 
	where ScheduleId = @ScheduleId;
if (@@ROWCOUNT = 0)
insert into CINEMA.SCHEDULE(TheatreId, MovieId, TicketsLeft, FromDate, ToDate)  
select @TheatreId, @MovieId, @TicketsLeft, @FromDate, @ToDate;

go

grant exec on CINEMA.SaveSchedule to ADMIN_ROLE
go

--12.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce toate salile din tabela CINEMA.THEATRE.

	- Parametri: n/a.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetTheatreName') is not null drop proc CINEMA.GetTheatreName
go

create proc CINEMA.GetTheatreName

as set nocount on

select * from CINEMA.THEATRE;

go

grant exec on CINEMA.GetTheatreName to ADMIN_ROLE
go

grant exec on CINEMA.GetTheatreName to PUBLIC_ROLE
go

--13.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Introduce o noua inregistrare in CINEMA.RESERVATION.

	- Parametri:  ReservationId, ScheduleId, Name, Telephone, NoOfSeats.

	- Output: n/a. */

if OBJECT_ID('CINEMA.SaveReservation') is not null drop proc CINEMA.SaveReservation 
go

create proc CINEMA.SaveReservation
	@ScheduleId	    int,
	@Name			varchar(255),
	@Telephone		varchar(20),
	@NoOfSeats		int,
	@SeatId			int
as set nocount on
declare @ReservationId int,
		@Tickets int

begin tran

select @Tickets = TicketsLeft from CINEMA.SCHEDULE where ScheduleId = @ScheduleId;
if @Tickets < 1 
begin
	rollback tran;
	raiserror('Ne pare rau, nu mai sunt suficiente locuri ramase.', 11, 1);
end
else 
begin
	insert into CINEMA.RESERVATION(ScheduleId, Name, Telephone, NoOfSeats)  
	select @ScheduleId, @Name, @Telephone, @NoOfSeats;

	select top 1 @ReservationId = ReservationId from CINEMA.RESERVATION order by ReservationId desc;
	insert into CINEMA.RESERVATION_SEATS(ReservationId, SeatId)
	select @ReservationId, @SeatId;

	update CINEMA.SCHEDULE set TicketsLeft = TicketsLeft - @NoOfSeats where ScheduleId = @ScheduleId;
end
commit tran

go

grant exec on CINEMA.SaveReservation to ADMIN_ROLE
go

grant exec on CINEMA.SaveReservation to PUBLIC_ROLE
go

--14.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce toate rezevarile din tabela CINEMA.RESERVATION.

	- Parametri: n/a.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetReservationsList') is not null drop proc CINEMA.GetReservationsList
go

create proc CINEMA.GetReservationsList

as set nocount on

select a.ReservationId, b.ScheduleId, b.TicketsLeft, b.FromDate, b.ToDate, c.MovieId, c.Title MovieName, d.TheatreId, d.Name TheatreName, a.Name ClientName, a.Telephone ClientTelephone, a.NoOfSeats
	   from CINEMA.RESERVATION a 
	   inner join CINEMA.SCHEDULE b on a.ScheduleId = b.ScheduleId
	   inner join CINEMA.MOVIE c on b.MovieId = c.MovieId
	   inner join CINEMA.THEATRE d on b.TheatreId = d.TheatreId; 

go

grant exec on CINEMA.GetReservationsList to ADMIN_ROLE
go

--15.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Sterge intregistrarea din CINEMA.RESERVATION cu id-ul primit ca parametru.

	- Parametri:  ReservationId.

	- Output: n/a. */

if OBJECT_ID('CINEMA.DeleteReservation') is not null drop proc CINEMA.DeleteReservation 
go

create proc CINEMA.DeleteReservation
	@ReservationId	int
as set nocount on

declare @Seats int,
		@Id	   int

begin tran

select @Seats = NoOfSeats, @Id = ScheduleId from CINEMA.RESERVATION where ReservationId = @ReservationId;

update CINEMA.SCHEDULE set TicketsLeft = TicketsLeft + @Seats where ScheduleId = @Id;
delete from CINEMA.RESERVATION_SEATS where ReservationId = @ReservationId;
delete from CINEMA.RESERVATION where ReservationId = @ReservationId;

commit tran

go

grant exec on CINEMA.DeleteReservation to ADMIN_ROLE
go
--16.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce locurile din CINEMA.SEAT in functie de ReservationId.

	- Parametri:  ReservationId.

	- Output: SeatId, RowLetter, SeatNumber. */

if OBJECT_ID('CINEMA.GetReservedSeats') is not null drop proc CINEMA.GetReservedSeats 
go

create proc CINEMA.GetReservedSeats
	@ReservationId int

as set nocount on

select * from CINEMA.SEAT a inner join CINEMA.RESERVATION_SEATS b on a.SeatId = b.SeatId
						    inner join CINEMA.RESERVATION c on c.ReservationId = b.ReservationId
							where c.ReservationId = @ReservationId;

go

grant exec on CINEMA.GetReservedSeats to ADMIN_ROLE
go

--17.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Aduce toate locurile din tabela CINEMA.SEAT.

	- Parametri: n/a.

	- Output: Tot. */

if OBJECT_ID('CINEMA.GetSeatsList') is not null drop proc CINEMA.GetSeatsList
go

create proc CINEMA.GetSeatsList

as set nocount on

select * from CINEMA.SEAT;

go

grant exec on CINEMA.GetSeatsList to ADMIN_ROLE
go

grant exec on CINEMA.GetSeatsList to PUBLIC_ROLE
go

--18.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Introduce o noua inregistrare in CINEMA.RESERVATION si seteaza nivelul de izolare al tranzactiei la Read Uncommitted.

	- Parametri:  ReservationId, ScheduleId, Name, Telephone, NoOfSeats.

	- Output: n/a. */
 
if OBJECT_ID('CINEMA.ReadUncommitted') is not null drop proc CINEMA.ReadUncommitted 
go

create proc CINEMA.ReadUncommitted
	@ScheduleId	    int,
	@Name			varchar(255),
	@Telephone		varchar(20),
	@NoOfSeats		int

as set nocount on

declare @ReservationId int,
		@Tickets int,
		@SeatId int

declare @old_data table(TicketsLeft int);

begin try

set transaction isolation level read uncommitted;
begin tran

	update CINEMA.SCHEDULE set TicketsLeft = TicketsLeft - @NoOfSeats
		output deleted.TicketsLeft into @old_data
		where ScheduleId = @ScheduleId;
	select @Tickets = TicketsLeft from @old_data;
	
	if @Tickets <= 0 
	begin
		rollback tran;
		raiserror('Ne pare rau, nu mai sunt suficiente locuri ramase.', 11, 1);
	end

	insert into CINEMA.RESERVATION(ScheduleId, Name, Telephone, NoOfSeats)  
		select @ScheduleId, @Name, @Telephone, @NoOfSeats;
	select @ReservationId = SCOPE_IDENTITY();

	select @SeatId = min(SeatId) from CINEMA.SEAT where SeatId not in (select a.SeatId from CINEMA.RESERVATION_SEATS a inner join CINEMA.RESERVATION b on a.ReservationId = b.ReservationId where b.ScheduleId = @ScheduleId);
	
	insert into CINEMA.RESERVATION_SEATS(ReservationId, SeatId) select @ReservationId, @SeatId;

commit tran
end try
begin catch
	if @@trancount > 0 rollback tran
end catch

go

grant exec on CINEMA.ReadUncommitted to ADMIN_ROLE
go

--19.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Introduce o noua inregistrare in CINEMA.RESERVATION si seteaza nivelul de izolare al tranzactiei la Read Committed.

	- Parametri:  ReservationId, ScheduleId, Name, Telephone, NoOfSeats.

	- Output: n/a. */
 
if OBJECT_ID('CINEMA.ReadCommitted') is not null drop proc CINEMA.ReadCommitted 
go

create proc CINEMA.ReadCommitted
	@ScheduleId	    int,
	@Name			varchar(255),
	@Telephone		varchar(20),
	@NoOfSeats		int

as set nocount on

declare @ReservationId int,
		@Tickets int,
		@SeatId int

declare @old_data table(TicketsLeft int);

begin try

set transaction isolation level read committed;
begin tran

	update CINEMA.SCHEDULE set TicketsLeft = TicketsLeft - @NoOfSeats
		output deleted.TicketsLeft into @old_data
		where ScheduleId = @ScheduleId;
	select @Tickets = TicketsLeft from @old_data;
	
	if @Tickets <= 0 
	begin
		rollback tran;
		raiserror('Ne pare rau, nu mai sunt suficiente locuri ramase.', 11, 1);
	end

	insert into CINEMA.RESERVATION(ScheduleId, Name, Telephone, NoOfSeats)  
		select @ScheduleId, @Name, @Telephone, @NoOfSeats;
	select @ReservationId = SCOPE_IDENTITY();

	select @SeatId = min(SeatId) from CINEMA.SEAT where SeatId not in (select a.SeatId from CINEMA.RESERVATION_SEATS a inner join CINEMA.RESERVATION b on a.ReservationId = b.ReservationId where b.ScheduleId = @ScheduleId);
	
	insert into CINEMA.RESERVATION_SEATS(ReservationId, SeatId) select @ReservationId, @SeatId;

commit tran
end try
begin catch
	if @@trancount > 0 rollback tran
end catch

go

grant exec on CINEMA.ReadCommitted to ADMIN_ROLE
go

--20.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Introduce o noua inregistrare in CINEMA.RESERVATION si seteaza nivelul de izolare al tranzactiei la Repeatable Read.

	- Parametri:  ReservationId, ScheduleId, Name, Telephone, NoOfSeats.

	- Output: n/a. */
 
if OBJECT_ID('CINEMA.RepeatableRead') is not null drop proc CINEMA.RepeatableRead 
go

create proc CINEMA.RepeatableRead
	@ScheduleId	    int,
	@Name			varchar(255),
	@Telephone		varchar(20),
	@NoOfSeats		int

as set nocount on

declare @ReservationId int,
		@Tickets int,
		@SeatId int

declare @old_data table(TicketsLeft int);

begin try

set transaction isolation level repeatable read;
begin tran

	update CINEMA.SCHEDULE set TicketsLeft = TicketsLeft - @NoOfSeats
		output deleted.TicketsLeft into @old_data
		where ScheduleId = @ScheduleId;
	select @Tickets = TicketsLeft from @old_data;
	
	if @Tickets <= 0 
	begin
		rollback tran;
		raiserror('Ne pare rau, nu mai sunt suficiente locuri ramase.', 11, 1);
	end

	insert into CINEMA.RESERVATION(ScheduleId, Name, Telephone, NoOfSeats)  
		select @ScheduleId, @Name, @Telephone, @NoOfSeats;
	select @ReservationId = SCOPE_IDENTITY();

	select @SeatId = min(SeatId) from CINEMA.SEAT where SeatId not in (select a.SeatId from CINEMA.RESERVATION_SEATS a inner join CINEMA.RESERVATION b on a.ReservationId = b.ReservationId where b.ScheduleId = @ScheduleId);
	
	insert into CINEMA.RESERVATION_SEATS(ReservationId, SeatId) select @ReservationId, @SeatId;

commit tran
end try
begin catch
	if @@trancount > 0 rollback tran
end catch

go

grant exec on CINEMA.RepeatableRead to ADMIN_ROLE
go

--21.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Introduce o noua inregistrare in CINEMA.RESERVATION si seteaza nivelul de izolare al tranzactiei la Snapshot.

	- Parametri:  ReservationId, ScheduleId, Name, Telephone, NoOfSeats.

	- Output: n/a. */
 
if OBJECT_ID('CINEMA.Snapshot') is not null drop proc CINEMA.Snapshot 
go

create proc CINEMA.Snapshot
	@ScheduleId	    int,
	@Name			varchar(255),
	@Telephone		varchar(20),
	@NoOfSeats		int

as set nocount on

declare @ReservationId int,
		@Tickets int,
		@SeatId int

declare @old_data table(TicketsLeft int);

begin try

set transaction isolation level snapshot;
begin tran

	update CINEMA.SCHEDULE set TicketsLeft = TicketsLeft - @NoOfSeats
		output deleted.TicketsLeft into @old_data
		where ScheduleId = @ScheduleId;
	select @Tickets = TicketsLeft from @old_data;
	
	if @Tickets <= 0 
	begin
		rollback tran;
		raiserror('Ne pare rau, nu mai sunt suficiente locuri ramase.', 11, 1);
	end

	insert into CINEMA.RESERVATION(ScheduleId, Name, Telephone, NoOfSeats)  
		select @ScheduleId, @Name, @Telephone, @NoOfSeats;
	select @ReservationId = SCOPE_IDENTITY();

	select @SeatId = min(SeatId) from CINEMA.SEAT where SeatId not in (select a.SeatId from CINEMA.RESERVATION_SEATS a inner join CINEMA.RESERVATION b on a.ReservationId = b.ReservationId where b.ScheduleId = @ScheduleId);
	
	insert into CINEMA.RESERVATION_SEATS(ReservationId, SeatId) select @ReservationId, @SeatId;

commit tran
end try
begin catch
	if @@trancount > 0 rollback tran
end catch

go

grant exec on CINEMA.Snapshot to ADMIN_ROLE
go

--22.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Introduce o noua inregistrare in CINEMA.RESERVATION si seteaza nivelul de izolare al tranzactiei la Serializable.

	- Parametri:  ReservationId, ScheduleId, Name, Telephone, NoOfSeats.

	- Output: n/a. */
 
if OBJECT_ID('CINEMA.Serializable') is not null drop proc CINEMA.Serializable 
go

create proc CINEMA.Serializable
	@ScheduleId	    int,
	@Name			varchar(255),
	@Telephone		varchar(20),
	@NoOfSeats		int

as set nocount on

declare @ReservationId int,
		@Tickets int,
		@SeatId int

declare @old_data table(TicketsLeft int);

begin try

set transaction isolation level serializable;
begin tran

	update CINEMA.SCHEDULE set TicketsLeft = TicketsLeft - @NoOfSeats
		output deleted.TicketsLeft into @old_data
		where ScheduleId = @ScheduleId;
	select @Tickets = TicketsLeft from @old_data;
	
	if @Tickets <= 0 
	begin
		rollback tran;
		raiserror('Ne pare rau, nu mai sunt suficiente locuri ramase.', 11, 1);
	end

	insert into CINEMA.RESERVATION(ScheduleId, Name, Telephone, NoOfSeats)  
		select @ScheduleId, @Name, @Telephone, @NoOfSeats;
	select @ReservationId = SCOPE_IDENTITY();

	select @SeatId = min(SeatId) from CINEMA.SEAT where SeatId not in (select a.SeatId from CINEMA.RESERVATION_SEATS a inner join CINEMA.RESERVATION b on a.ReservationId = b.ReservationId where b.ScheduleId = @ScheduleId);
	
	insert into CINEMA.RESERVATION_SEATS(ReservationId, SeatId) select @ReservationId, @SeatId;

commit tran
end try
begin catch
	if @@trancount > 0 rollback tran
end catch

go

grant exec on CINEMA.Serializable to ADMIN_ROLE
go

--22.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Verifica daca user-ul este admin.

	- Parametri:  IsAdmin.

	- Output: n/a. */

if OBJECT_ID('CINEMA.IsAdmin') is not null drop proc CINEMA.IsAdmin 
go

create proc CINEMA.IsAdmin
	@IsAdmin		bit = null out
as set nocount on
select @IsAdmin = IS_MEMBER('db_owner') | IS_MEMBER('ADMIN_ROLE');
go

grant exec on CINEMA.IsAdmin to [anonymous_access]
go

grant exec on CINEMA.IsAdmin to ADMIN_ROLE
go

grant exec on CINEMA.IsAdmin to PUBLIC_ROLE
go

--24.----------------------------------------------------------------------------------------------------------------------------

/*	- Functionalitate: Creeaza un user nou.

	- Parametri:  UserName, Password.

	- Output: n/a. */

if OBJECT_ID('CINEMA.CreateUser') is not null drop proc CINEMA.CreateUser 
go

create proc CINEMA.CreateUser
	@UserName		sysname,
	@Password		sysname
with execute as owner

as set nocount on

begin try
	declare @query		nvarchar(max) = 'create user ' + QUOTENAME(@UserName) + ' with password = ''' + REPLACE(@Password, '''', '''''') + '''';
begin tran
	exec(@query);
	select @query = 'alter role PUBLIC_ROLE add member [' + @UserName + ']';
	exec(@query);
commit tran
end try

begin catch
	if @@TRANCOUNT > 0 rollback tran
	declare @ERROR_MESSAGE	nvarchar(max) = ERROR_MESSAGE();
	raiserror(@ERROR_MESSAGE, 11, 1);
end catch
go

grant exec on CINEMA.CreateUser to ADMIN_ROLE
go

grant exec on CINEMA.CreateUser to PUBLIC_ROLE
go

grant exec on CINEMA.CreateUser to [anonymous_access]
go
---------------------------------------------------------------------------------------------------------------------------------

select * from CINEMA.RESERVATION
select * from CINEMA.RESERVATION_SEATS
select * from CINEMA.SCHEDULE
select * from CINEMA.SEAT

delete from CINEMA.RESERVATION_SEATS
delete from CINEMA.RESERVATION
update CINEMA.SCHEDULE set TicketsLeft = 1000

