# Netflix-Insights
This project dives deep into Netflix's content catalog using PostgreSQL to uncover insights. It includes queries for content categorization, actor analysis, genre exploration, and year-wise release patterns.

### Problems Addressed:

```sql
-- 1. No. of Movies Vs TV Shows

-- 2. Most common rating for Movies and TV shows

-- 3. Movies released in 2020

-- 4. Top 5 countries with the most content on Netflix

-- 5. Identify the longest movie

-- 6. Content added in the last 5 years

-- 7. Movies/TV Shows by the Director Steven Spielberg

-- 8. TV Shows that lasted longer than 5 seasons

-- 9. Content in each Genre

-- 10. Average amount of content released by US each year on Netflix

-- 11. Movies that are documentaries

-- 12. Content without director

-- 13. Track Meryl Streep movies in the last 10 years

-- 14. Top 10 actors who appeared in the most number of movies in the US

-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

```
# Netflix Data Analysis

## About

This project analyzes Netflix data to explore trends in movies and TV shows. It includes insights into content distribution, ratings, popular genres, and various key metrics using SQL queries.

## Dataset

The dataset contains information on Netflix shows, including title, director, actors, country, release year, rating, duration, genres, and descriptions.

### Table Structure

| Column        | Description                | Data Type     |
| ------------- | -------------------------- | ------------- |
| show\_id      | Unique ID for the show     | VARCHAR(6)    |
| type          | Movie or TV Show           | VARCHAR(10)   |
| title         | Name of the show           | VARCHAR(150)  |
| director      | Director of the show       | VARCHAR(250)  |
| actors        | Main actors in the show    | VARCHAR(1000) |
| country       | Country of production      | VARCHAR(150)  |
| date\_added   | Date when added to Netflix | VARCHAR(75)   |
| release\_year | Year of release            | INT           |
| rating        | Age rating                 | VARCHAR(10)   |
| duration      | Duration (minutes/seasons) | VARCHAR(20)   |
| listed\_in    | Genres                     | VARCHAR(100)  |
| description   | Brief summary of the show  | VARCHAR(300)  |


## Approach Used

1. **Database Setup** - Created a table and inserted data.
2. **Data Cleaning** - Handling NULL values and formatting fields.
3. **Feature Extraction** - Splitting multi-value columns for better analysis.
4. **Exploratory Data Analysis (EDA)** - Running SQL queries to generate insights.

## Tools Used

- PostgreSQL
- SQL Queries for data analysis

## Conclusion

This project provides insights into Netflix's content library, trends, and key information using SQL-based analysis.

---

You can explore and use the SQL queries for your projects. Contributions are welcome! 🚀
