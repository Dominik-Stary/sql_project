WITH gdp_yoy AS (
    SELECT
        year,
        ROUND(gdp::numeric, 2) AS gdp,
        LAG(gdp) OVER (ORDER BY year) AS prev_gdp,
        ROUND(((gdp - LAG(gdp) OVER (ORDER BY year)) / LAG(gdp) OVER (ORDER BY year) * 100)::numeric, 2) AS gdp_pct_change
    FROM t_dominik_stary_project_SQL_secondary_final
    WHERE country = 'Czech Republic'
)
, wage_yoy AS (
    SELECT
        year,
        ROUND(AVG(avg_payroll)::numeric, 2) AS avg_wage,
        LAG(ROUND(AVG(avg_payroll)::numeric, 2)) OVER (ORDER BY year) AS prev_wage,
        ROUND(((AVG(avg_payroll) - LAG(AVG(avg_payroll)) OVER (ORDER BY year)) / LAG(AVG(avg_payroll)) OVER (ORDER BY year) * 100)::numeric, 2) AS wage_pct_change
    FROM t_dominik_stary_project_SQL_primary_final
    GROUP BY year
)
, price_yoy AS (
    SELECT
        year,
        ROUND(AVG(avg_price)::numeric, 2) AS avg_price,
        LAG(ROUND(AVG(avg_price)::numeric, 2)) OVER (ORDER BY year) AS prev_price,
        ROUND(((AVG(avg_price) - LAG(AVG(avg_price)) OVER (ORDER BY year)) / LAG(AVG(avg_price)) OVER (ORDER BY year) * 100)::numeric, 2) AS price_pct_change
    FROM t_dominik_stary_project_SQL_primary_final
    GROUP BY year
)
SELECT
    g.year,
    g.gdp_pct_change,
    w.wage_pct_change,
    p.price_pct_change
FROM gdp_yoy g
JOIN wage_yoy w USING(year)
JOIN price_yoy p USING(year)
WHERE g.prev_gdp IS NOT NULL
ORDER BY g.year;
