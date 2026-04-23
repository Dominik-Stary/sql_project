# SQL Projekt – Dostupnost základních potravin v ČR

## Zadání
Cílem projektu je analyzovat dostupnost základních potravin na základě vývoje mezd a cen v České republice.

Výzkumné otázky:
1. Rostou mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik si lze koupit litrů mléka a kilogramů chleba za první a poslední období?
3. Která kategorie potravin zdražuje nejpomaleji?
4. Existuje rok, kdy ceny potravin rostly výrazně více než mzdy (>10 p.b.)?
5. Má HDP vliv na změny mezd a cen potravin?

---

## Datové zdroje
Projekt využívá následující tabulky:
- czechia_payroll
- czechia_payroll_industry_branch
- czechia_price
- czechia_price_category
- economies
- countries

---

## Vytvořené tabulky

### Primary tabulka
`t_dominik_stary_project_SQL_primary_final`
Obsahuje:
- rok
- odvětví
- průměrnou mzdu
- kategorii potraviny
- průměrnou cenu

Script: `create_primary.sql`

---

### Secondary tabulka
`t_dominik_stary_project_SQL_secondary_final`

Obsahuje:
- rok
- stát
- HDP
- GINI
- populaci

Script: `create_secondary.sql`

---

## Postup řešení
- data nebyla upravována, pouze agregována pomocí SQL
- byly vypočítány meziroční změny (YoY)
- analyzovány vztahy mezi mzdami, cenami a HDP
- databáze byla v read-only režimu, proto jsou tabulky dodány formou SQL scriptů

---

## Výsledky

### 1. Vývoj mezd
Mzdy v průběhu let obecně rostou, ale ne ve všech odvětvích a letech.

Například v roce 2013 došlo k meziročnímu poklesu mezd o −6,76 %. Naopak v roce 2018 mzdy výrazně vzrostly o +13,38 %.

Z toho vyplývá, že vývoj mezd není stabilní a obsahuje i poklesy.

---

### 2. Kupní síla
Kupní síla se v čase zvýšila.

V prvním sledovaném období (2006) bylo možné koupit:
- 1437 litrů mléka
- 1287 kg chleba

V posledním období (2018):
- 1641 litrů mléka
- 1342 kg chleba

To znamená, že mzdy rostly rychleji než ceny těchto potravin.

---

### 3. Nejpomaleji zdražující potravina
Nejpomaleji zdražující kategorií je cukr krystalový.

Jeho průměrná meziroční změna ceny činí −1,92 %, což znamená, že jeho cena v průběhu sledovaného období dokonce mírně klesala.

To z něj činí nejstabilnější (resp. nejméně rostoucí) položku ze všech sledovaných potravin.

---

### 4. Ceny vs. mzdy
Ano, existuje rok, kdy ceny potravin rostly výrazně více než mzdy.

V roce 2013 mzdy klesly o −6,76 %, zatímco ceny potravin vzrostly o +5,10 %. Rozdíl činil +11,86 procentního bodu.

---

### 5. Vliv HDP
Růst HDP má vliv na vývoj mezd, ale méně na ceny potravin.

Například v roce 2007 vzrostlo HDP o +5,57 % a mzdy o +6,19 %. Naopak v roce 2012 HDP kleslo o −0,79 %, ale ceny potravin vzrostly o +6,73 %.

Z toho vyplývá, že vztah mezi HDP a mzdami je silnější než mezi HDP a cenami potravin.
