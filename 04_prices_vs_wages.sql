WITH wages AS (
    SELECT
        year,
        ROUND(AVG(avg_payroll)::numeric, 2) AS avg_wage
    FROM t_dominik_stary_project_SQL_primary_final
    GROUP BY year
),
wages_yoy AS (
    SELECT
        year,
        avg_wage,
        LAG(avg_wage) OVER (ORDER BY year) AS prev_wage,
        CASE 
            WHEN LAG(avg_wage) OVER (ORDER BY year) IS NULL THEN NULL
            ELSE ROUND(((avg_wage - LAG(avg_wage) OVER (ORDER BY year)) / LAG(avg_wage) OVER (ORDER BY year) * 100)::numeric, 2)
        END AS wage_pct_change
    FROM wages
),
prices AS (
    SELECT
        year,
        ROUND(AVG(avg_price)::numeric, 2) AS avg_food_price
    FROM t_dominik_stary_project_SQL_primary_final
    GROUP BY year
),
prices_yoy AS (
    SELECT
        year,
        avg_food_price,
        LAG(avg_food_price) OVER (ORDER BY year) AS prev_price,
        CASE 
            WHEN LAG(avg_food_price) OVER (ORDER BY year) IS NULL THEN NULL
            ELSE ROUND(((avg_food_price - LAG(avg_food_price) OVER (ORDER BY year)) / LAG(avg_food_price) OVER (ORDER BY year) * 100)::numeric, 2)
        END AS price_pct_change
    FROM prices
)
SELECT
    w.year,
    w.avg_wage,
    w.wage_pct_change,
    p.avg_food_price,
    p.price_pct_change,
    ROUND((p.price_pct_change - w.wage_pct_change)::numeric, 2) AS diff_pct
FROM wages_yoy w
JOIN prices_yoy p USING(year)
WHERE w.prev_wage IS NOT NULL
  AND p.prev_price IS NOT NULL
ORDER BY w.year;
	
