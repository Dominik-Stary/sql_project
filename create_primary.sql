CREATE TABLE t_dominik_stary_project_SQL_primary_final AS
SELECT
    cp.payroll_year AS year,
    cp.industry_branch_code AS id_branch,
    pib.name AS branch,
    ROUND(AVG(cp.value)::numeric, 2) AS avg_payroll,
    cpc.code AS id_goods,
    cpc.name AS goods,
    ROUND(AVG(cpr.value)::numeric, 2) AS avg_price
FROM data_academy_content.czechia_payroll cp
JOIN data_academy_content.czechia_payroll_industry_branch pib
    ON cp.industry_branch_code = pib.code
JOIN data_academy_content.czechia_price cpr
    ON EXTRACT(YEAR FROM cpr.date_from) = cp.payroll_year
JOIN data_academy_content.czechia_price_category cpc
    ON cpr.category_code = cpc.code
WHERE cp.value_type_code = 5958
GROUP BY
    cp.payroll_year,
    cp.industry_branch_code,
    pib.name,
    cpc.code,
    cpc.name
ORDER BY year, id_branch;