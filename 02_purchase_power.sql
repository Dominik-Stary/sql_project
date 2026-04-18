WITH final AS (
    WITH avg_wage AS (
        SELECT year, ROUND(AVG(avg_payroll)::numeric, 2) AS avg_wage
        FROM t_dominik_stary_project_SQL_primary_final
        GROUP BY year
    ),
    milk_price AS (
        SELECT year, ROUND(AVG(avg_price)::numeric, 2) AS avg_price_milk
        FROM t_dominik_stary_project_SQL_primary_final
        WHERE goods ILIKE '%mléko%'
        GROUP BY year
    ),
    bread_price AS (
        SELECT year, ROUND(AVG(avg_price)::numeric, 2) AS avg_price_bread
        FROM t_dominik_stary_project_SQL_primary_final
        WHERE goods ILIKE '%chléb%'
        GROUP BY year
    )
    SELECT
        w.year,
        w.avg_wage,
        m.avg_price_milk,
        b.avg_price_bread,
        ROUND(w.avg_wage / m.avg_price_milk, 2) AS liters_of_milk,
        ROUND(w.avg_wage / b.avg_price_bread, 2) AS kgs_of_bread
    FROM avg_wage w
    JOIN milk_price m USING(year)
    JOIN bread_price b USING(year)
)
SELECT *
FROM final
WHERE year IN (
    (SELECT MIN(year) FROM final),
    (SELECT MAX(year) FROM final)
)
ORDER BY year;
