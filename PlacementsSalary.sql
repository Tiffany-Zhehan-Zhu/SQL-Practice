/*
https://www.hackerrank.com/challenges/placements/problem

Placements

You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. 
Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 
Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

Write a query to output the names of those students whose best friends got offered a higher salary than them. 
Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.
*/

SELECT S.Name
FROM Students S JOIN Friends F ON S.ID=F.ID
                JOIN Packages PF ON PF.ID=F.Friend_ID 
                JOIN Packages P ON P.ID=S.ID
WHERE PF.Salary > P.Salary
ORDER BY PF.Salary
