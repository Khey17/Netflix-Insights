-- Netflix Data Analysis

-- DROP TABLE netflix;

CREATE TABLE netflix (
	show_id VARCHAR(6),
	type VARCHAR(10),
	title VARCHAR(150),
	director VARCHAR(250),
	actors VARCHAR(1000),
	country VARCHAR(150),
	date_added VARCHAR(75),
	release_year INT,
	rating VARCHAR(10),
	duration VARCHAR(20),
	listed_in VARCHAR(100),
	description VARCHAR(300)
);

SELECT * FROM netflix;

-- 1. No. of Movies Vs TV Shows
SELECT DISTINCT type, COUNT(*) 
	FROM netflix GROUP BY type;

-- 2. Most common rating for Movies and TV shows
SELECT type, rating
FROM
(
SELECT rating, type, COUNT(*) AS count,
	RANK () OVER (PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
FROM netflix GROUP BY type, rating
	) AS subtable1 WHERE ranking = 1;

-- 3. Movies released in 2020
SELECT * FROM netflix
	WHERE type = 'Movie' AND release_year = 2020;

-- Top 5 countries with the most content on Netflix
SELECT * FROM
(
SELECT country, COUNT(show_id) FROM netflix
	GROUP BY country 
ORDER BY COUNT(show_id) DESC LIMIT 6
	) AS subtable2 WHERE country IS NOT NULL;

-- Alternate method aka the right method (Since countries are grouped together)
SELECT
	UNNEST (STRING_TO_ARRAY(country, ', ')) as new_country,
	COUNT(show_id)
FROM netflix
GROUP BY new_country ORDER BY COUNT(show_id) DESC LIMIT 5;


-- 5. Identify the longest movie
SELECT * FROM netflix 
	WHERE type = 'Movie' AND 
duration = (SELECT MAX(duration) FROM netflix);

-- 6. Content added in the last 5 years
SELECT * FROM netflix
	WHERE TO_DATE(date_added, 'Month DD, YYYY') >= 
	CURRENT_DATE - INTERVAL '5 years';


-- 7. Movies/TV Shows by the Director Steven Spielberg
SELECT * FROM netflix 
	WHERE director ILIKE '%Steven Spielberg%';


-- 8. TV Shows that lasted longer than 5 seasons
SELECT * FROM netflix
	WHERE type = 'TV Show' AND duration IS NOT NULL
AND CAST(SPLIT_PART(duration, ' ', 1) AS INT) >= 5;

-- 9. Content in each Genre
SELECT
	UNNEST (STRING_TO_ARRAY(listed_in, ', ')) as genre,
	COUNT(show_id) FROM netflix
GROUP BY genre;



-- 10. Average amount of content released by US each year on Netflix
SELECT
	EXTRACT (YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
	COUNT(show_id),
	ROUND(
		COUNT(show_id)::numeric/(SELECT COUNT(show_id) FROM netflix WHERE country LIKE '%United States%')::numeric * 100
		, 2) AS avg_content_based_in_US
	FROM netflix
WHERE country LIKE '%United States%' AND date_added IS NOT NULL
GROUP BY year;


-- 11. Movies that are documentaries
-- Amateur way of doing it
SELECT * FROM
	(
	SELECT *,
	UNNEST (STRING_TO_ARRAY(listed_in, ', ')) AS genre
 	FROM netflix
	) AS subtable3
WHERE type = 'Movie' AND genre = 'Documentaries';

-- Right way
SELECT * FROM netflix
	WHERE listed_in ILIKE '%documentaries%';

-- 12. Content without director
SELECT * FROM netflix
	WHERE director is NULL;

-- 13. Track Meryl Streep movies in last 10 years
SELECT show_id, title FROM netflix
	WHERE actors ILIKE '%Mark Wahlberg%' AND
TO_DATE(date_added, 'Month DD, YYYY') >= (
	SELECT MAX(TO_DATE(date_added, 'Month DD, YYYY')) - INTERVAL '10 years'
FROM netflix);


-- 14. Top 10 actors who appeared in most number of movies in the US.
SELECT actor, COUNT(show_id) FROM
	(
	SELECT *,
	UNNEST (STRING_TO_ARRAY(actors, ', ')) AS actor
	FROM netflix
	WHERE country ILIKE '%United States%' AND type = 'Movie'
	) AS subtable4
GROUP BY actor ORDER BY COUNT(show_id) DESC LIMIT 10;


-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.
SELECT category, COUNT(show_id) FROM
	(
	SELECT show_id,
	CASE
		WHEN description ILIKE '%kill' OR 
		description ILIKE '%violence%' THEN 'Bad'
		ELSE 'Good'
	END AS category
	FROM netflix
	) GROUP BY category;