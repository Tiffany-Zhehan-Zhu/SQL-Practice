/*
https://www.hackerrank.com/challenges/sql-projects/problem

SQL Project Planning

You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.

If the End_Date of the tasks are consecutive, then they are part of the same project. 
Samantha is interested in finding the total number of different projects completed.
Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
If there is more than one project that have the same number of completion days, then order by the start date of the project.

*/

SELECT Project_Start_Date, Project_End_Date
FROM (SELECT DISTINCT IF(P.S_Date IS NULL, LAG(P.S_Date) OVER(), P.S_Date) AS Project_Start_Date,
                IF(P.E_Date IS NULL, LEAD(P.E_Date) OVER(), P.E_Date) AS Project_End_Date
    FROM(SELECT IF(P2.Task_ID IS NULL, P1.Start_Date, NULL) AS S_Date,
                IF(P3.Task_ID IS NULL, P1.End_Date, NULL) AS E_Date 
         FROM Projects P1 LEFT JOIN Projects P2 ON P1.Start_Date = P2.End_Date
                          LEFT JOIN Projects P3 ON P1.End_Date = P3.Start_Date
        WHERE P2.Task_ID IS NULL OR P3.Task_ID IS NULL) AS P
    ) AS Project
ORDER BY Project_End_Date - Project_Start_Date, Project_Start_Date


/* To get the start date of each project */                          
SELECT P1.Start_Date
FROM Projects P1 LEFT JOIN Projects P2 ON P1.Start_Date = P2.End_Date
WHERE P2.Task_ID IS NULL

/* To get the end date of each project */
SELECT P1.End_Date 
FROM Projects P1 LEFT JOIN Projects P3 ON P1.End_Date = P3.Start_Date
WHERE P3.Task_ID IS NULL
                          
                          
