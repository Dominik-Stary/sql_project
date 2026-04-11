# SQL Projekt – Dostupnost základních potravin v ČR

## Zadání
Cílem projektu je analyzovat dostupnost základních potravin pro obyvatele České republiky na základě vývoje mezd a cen v čase.

Projekt odpovídá na následující výzkumné otázky:

1. Rostou mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik si lze koupit mléka a chleba za první a poslední období?
3. Která potravina zdražuje nejpomaleji?
4. Existuje rok, kdy ceny rostly výrazně více než mzdy (>10 p.b.)?
5. Má HDP vliv na změny mezd a cen potravin?

---

## Datové zdroje

Použitá data:

- mzdy v ČR (czechia_payroll)
- ceny potravin (czechia_price)
- kategorie potravin (czechia_price_category)
- ekonomická data států (economies, countries)

---

## Výstupní tabulky

V projektu byly vytvořeny dvě hlavní tabulky:

### Primary
`t_dominik_stary_project_SQL_primary_final`

Obsahuje:
- rok
- odvětví
- průměrnou mzdu
- kategorii potraviny
- průměrnou cenu

---

### Secondary
`t_dominik_stary_project_SQL_secondary_final`

Obsahuje:
- rok
- stát
- HDP
- GINI
- populaci

---

## Postup

- data nebyla upravována, pouze agregována
- byly vytvořeny SQL dotazy pro výpočet:
  - meziročních změn
  - průměrů
  - kupní síly
- výsledky byly exportovány do CSV (read-only DB)

---
