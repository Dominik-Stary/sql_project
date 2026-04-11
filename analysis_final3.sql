WITH prices AS (
    SELECT DISTINCT
        year,
        id_goods,
        goods,
        avg_price
    FROM t_dominik_stary_project_SQL_primary_final
),
prices_yoy AS (
    SELECT
        year,
        id_goods,
        goods,
        avg_price,
        LAG(avg_price) OVER (PARTITION BY id_goods ORDER BY year) AS prev_price
    FROM prices
),
pct_changes AS (
    SELECT
        id_goods,
        goods,
        year,
        ROUND(avg_price::numeric, 2) AS avg_price,
        ROUND(prev_price::numeric, 2) AS prev_price,
        CASE 
            WHEN prev_price IS NULL THEN NULL
            ELSE ROUND(((avg_price - prev_price) / prev_price * 100)::numeric, 2)
        END AS pct_change
    FROM prices_yoy
    WHERE prev_price IS NOT NULL
)
SELECT
    id_goods,
    goods,
    ROUND(AVG(pct_change)::numeric, 2) AS avg_pct_growth
FROM pct_changes
GROUP BY id_goods, goods
ORDER BY avg_pct_growth ASC;
