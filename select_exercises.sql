USE albums_db;

/* Explore the structure of the albums table.

a. How many rows are in the albums table? 31

b. How many unique artist names are in the albums table? 23

c. What is the primary key for the albums table? The Primary key is the id

d. What is the oldest release date for any album in the albums table? What is the most recent release date?
The oldest release date in the table is 1967, and the newest is 2011

*/

SELECT *
FROM albums
ORDER BY release_date DESC;

SELECT *
FROM albums
ORDER BY release_date ASC;

-- The name of all albums by Pink Floyd

SELECT name 
FROM albums
WHERE artist = 'Pink Floyd';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released

SELECT release_date 
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- The genre for the album Nevermind

SELECT genre 
FROM albums
WHERE name = 'Nevermind';

-- Which albums were released in the 1990s

SELECT *
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

-- Which albums had less than 20 million certified sales

SELECT name,
		sales 
FROM albums 
WHERE sales < '20.0';

-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?

SELECT *
FROM albums
WHERE genre = 'Rock';

-- In this case, the operator '=' pulls checks the genre column for each entry, and if it matches exactly the word 'Rock", then it returns that entry, and ignores all else.

