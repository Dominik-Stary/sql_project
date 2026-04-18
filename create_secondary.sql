CREATE TABLE t_dominik_stary_project_SQL_secondary_final AS
SELECT
    e.year,
    e.country,
    e.GDP,
    e.gini,
    e.population
FROM data_academy_content.economies e
JOIN data_academy_content.countries c
    ON e.country = c.country
WHERE c.continent = 'Europe'
ORDER BY e.year;