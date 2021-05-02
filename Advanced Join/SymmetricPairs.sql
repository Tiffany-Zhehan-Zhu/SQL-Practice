/*
https://www.hackerrank.com/challenges/symmetric-pairs/problem

Symmetric Pairs

You are given a table, Functions, containing two columns: X and Y.
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
*/


SELECT DISTINCT X, Y
FROM Functions 
WHERE (X, Y) IN (SELECT F1.Y, F1.X FROM Functions F1 )
    AND (X, Y) NOT IN (SELECT F2.X, F2.Y FROM Functions F2 WHERE F2.X=F2.Y GROUP BY F2.X, F2.Y HAVING COUNT(*)=1)
    AND X<=Y 
ORDER BY X
