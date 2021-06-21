----------------------------------------------------------

---CINEMA.MOVIE_RATING---

insert into CINEMA.MOVIE_RATING(Name, Acronym, Description)
select 'General Audiences', 'G', 'All ages admitted. Nothing that would offend parents for viewing by children.';

insert into CINEMA.MOVIE_RATING(Name, Acronym, Description)
select 'Parental Guidance Suggested', 'PG', 'Some material may not be suitable for children. Parents urged to give "parental guidance". May contain some material parents might not like for their young children.';

insert into CINEMA.MOVIE_RATING(Name, Acronym, Description)
select 'Parents Strongly Cautioned', 'PG-13', 'Some material may be inappropriate for children under 13. Parents are urged to be cautious. Some material may be inappropriate for pre-teenagers.';

insert into CINEMA.MOVIE_RATING(Name, Acronym, Description)
select 'Restricted', 'R', 'Under 17 requires accompanying parent or adult guardian. Contains some adult material. Parents are urged to learn more about the film before taking their young children with them.';

insert into CINEMA.MOVIE_RATING(Name, Acronym, Description)
select 'Adults Only', 'NC-17', 'No One 17 and Under Admitted. Clearly adult. Children are not admitted.';

select * from CINEMA.MOVIE_RATING;

----------------------------------------------------------

---CINEMA.GENRE---

insert into CINEMA.MOVIE_GENRE(Name) values ('Absurdist/surreal/whimsical'),
										    ('Action'),	
										    ('Adventure'),
										    ('Comedy'),
										    ('Crime'),
										    ('Drama'),
										    ('Fantasy'),
										    ('Historical'),
										    ('Historical fiction'),
										    ('Horror'),
										    ('Magical realism'),
										    ('Mystery'),
										    ('Paranoid'),
										    ('Philosophical'),
										    ('Political'),
										    ('Romance'),
										    ('Saga'),
										    ('Satire'),
										    ('Science fiction'),
										    ('Slice of Life'),
										    ('Speculative'),
										    ('Thriller'),
										    ('Urban'),
										    ('Western');

select * from CINEMA.MOVIE_GENRE;

----------------------------------------------------------

---CINEMA.THEATRE---

insert into CINEMA.THEATRE(Name) values ('Sala 1'),
										('Sala 2'),
										('Sala 3'),
										('Sala 4'),
										('Sala 5'),
										('Sala 6'),
										('Sala 7'),
										('Sala 8'),
										('Sala 9'),
										('Sala 10'),
										('Sala 11'),
										('Sala 12');

select * from CINEMA.THEATRE;

----------------------------------------------------------

---CINEMA.SEAT---

insert into CINEMA.SEAT(RowLetter, SeatNumber) values ('A', 1), ('A', 2), ('A', 3), ('A', 4), ('A', 5), ('A', 6), ('A', 7), ('A', 8), ('A', 9), ('A', 10), ('A', 11), ('A', 12), ('A', 13), ('A', 14), ('A', 15),
													  ('B', 1), ('B', 2), ('B', 3), ('B', 4), ('B', 5), ('B', 6), ('B', 7), ('B', 8), ('B', 9), ('B', 10), ('B', 11), ('B', 12), ('B', 13), ('B', 14), ('B', 15),
													  ('C', 1), ('C', 2), ('C', 3), ('C', 4), ('C', 5), ('C', 6), ('C', 7), ('C', 8), ('C', 9), ('C', 10), ('C', 11), ('C', 12), ('C', 13), ('C', 14), ('C', 15),
													  ('D', 1), ('D', 2), ('D', 3), ('D', 4), ('D', 5), ('D', 6), ('D', 7), ('D', 8), ('D', 9), ('D', 10), ('D', 11), ('D', 12), ('D', 13), ('D', 14), ('D', 15),
													  ('E', 1), ('E', 2), ('E', 3), ('E', 4), ('E', 5), ('E', 6), ('E', 7), ('E', 8), ('E', 9), ('E', 10), ('E', 11), ('E', 12), ('E', 13), ('E', 14), ('E', 15),
													  ('F', 1), ('F', 2), ('F', 3), ('F', 4), ('F', 5), ('F', 6), ('F', 7), ('F', 8), ('F', 9), ('F', 10), ('F', 11), ('F', 12), ('F', 13), ('F', 14), ('F', 15),
													  ('G', 1), ('G', 2), ('G', 3), ('G', 4), ('G', 5), ('G', 6), ('G', 7), ('G', 8), ('G', 9), ('G', 10), ('G', 11), ('G', 12), ('G', 13), ('G', 14), ('G', 15),
													  ('H', 1), ('H', 2), ('H', 3), ('H', 4), ('H', 5), ('H', 6), ('H', 7), ('H', 8), ('H', 9), ('H', 10), ('H', 11), ('H', 12), ('H', 13), ('H', 14), ('H', 15),
													  ('I', 1), ('I', 2), ('I', 3), ('I', 4), ('I', 5), ('I', 6), ('I', 7), ('I', 8), ('I', 9), ('I', 10), ('I', 11), ('I', 12), ('I', 13), ('I', 14), ('I', 15),
													  ('J', 1), ('J', 2), ('J', 3), ('J', 4), ('J', 5), ('J', 6), ('J', 7), ('J', 8), ('J', 9), ('J', 10), ('J', 11), ('J', 12), ('J', 13), ('J', 14), ('J', 15),
													  
select * from CINEMA.SEAT;

----------------------------------------------------------
