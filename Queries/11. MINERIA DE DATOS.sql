WITH

;WITH CTE AS ( SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS row_num FROM customers )
DELETE FROM CTE WHERE row_num = 5;


SELECT DISTINCT [NAME] FROM EMPLOYEES
WHERE LEFT([NAME], 1) IN ('a', 'e', 'i', 'o', 'u') 
  AND RIGHT([NAME], 1) IN ('a', 'e', 'i', 'o', 'u');

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT [NAME]
FROM EMPLOYEES
WHERE LEFT([NAME], 1) NOT IN ('a', 'e', 'i', 'o', 'u');

SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u');

-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u')
   OR RIGHT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u');


SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u')
  AND RIGHT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u');

