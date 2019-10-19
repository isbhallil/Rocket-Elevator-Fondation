# README


## Number of single request (ContactId) created by month (Creation date)
SELECT COUNT(id), to_char( creation_date, 'yyyy-mm')
FROM fact_contacts
GROUP BY to_char( creation_date, 'yyyy-mm')
ORDER BY to_char( creation_date, 'yyyy-mm')

## Unique number of single monthly requests. (Creation dates)
SELECT extract(YEAR FROM submited_at) AS YEAR, extract(MONTH FROM submited_at) AS MONTH, COUNT(quote_id)
FROM      fact_quotes
GROUP BY  YEAR, MONTH
ORDER BY  YEAR, MONTH

Le nombre de demandes uniques (QuoteId) groupées par Mois (Date de création)

## Number elevators in each building belonging to each customers
SELECT company_name, elevators_count FROM dim_customers
GROUP BY company_name, elevators_count
ORDER BY elevators_count;


In order to generate the mysql db the command to use id rake db:repopulate

In order to generate the postgres db the command to use is rake pg:reset and then afterwards rake pg:etl
