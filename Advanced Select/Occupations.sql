/*
https://www.hackerrank.com/challenges/occupations

Occupations

Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. 
The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.
*/

SET @Didx=0, @Pidx=0, @Sidx=0, @Aidx=0;

SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor)
FROM(SELECT IF(Occupation = 'Doctor', Name, NULL) AS Doctor,
       IF(Occupation = 'Professor', Name, NULL) AS Professor,
       IF(Occupation = 'Singer', Name, NULL) AS Singer,
       IF(Occupation = 'Actor', Name, NULL) AS Actor,
       CASE WHEN Occupation = 'Doctor' THEN @Didx := @Didx + 1
            WHEN Occupation = 'Professor' THEN @Pidx := @Pidx + 1
            WHEN Occupation = 'Singer' THEN @Sidx := @Sidx + 1
            WHEN Occupation = 'Actor' THEN @Aidx := @Aidx + 1 END AS RowNo
FROM OCCUPATIONS 
ORDER BY Name) AS O
GROUP BY RowNo
