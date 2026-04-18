WITH wages AS (
    SELECT DISTINCT
        year,
        id_branch,
        branch,
        avg_payroll
    FROM t_dominik_stary_project_SQL_primary_final
),
wages_yoy AS (
    SELECT
        year,
        id_branch,
        branch,
        ROUND(avg_payroll::numeric, 2) AS avg_payroll,
        LAG(ROUND(avg_payroll::numeric, 2)) OVER (PARTITION BY id_branch ORDER BY year) AS prev_payroll,
        ROUND(
            (
                ROUND(avg_payroll::numeric, 2) 
                - LAG(ROUND(avg_payroll::numeric, 2)) OVER (PARTITION BY id_branch ORDER BY year)
            )
            / LAG(ROUND(avg_payroll::numeric, 2)) OVER (PARTITION BY id_branch ORDER BY year) * 100
        , 2) AS pct_change
    FROM wages
)
SELECT
    year,
    id_branch,
    branch,
    avg_payroll,
    prev_payroll,
    pct_change
FROM wages_yoy
WHERE prev_payroll IS NOT NULL
ORDER BY id_branch, year;
