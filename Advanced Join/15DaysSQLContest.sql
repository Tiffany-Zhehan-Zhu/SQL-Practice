/*
https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem

15 Days of Learning SQL

Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

Write a query to print total number of unique hackers who made at least 1 submission each day (starting on the first day of the contest), 
and find the hacker_id and name of the hacker who made maximum number of submissions each day. 
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
The query should print this information for each day of the contest, sorted by the date.

The following tables hold contest data:
Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.
Submissions: The submission_date is the date of the submission, submission_id is the id of the submission, 
hacker_id is the id of the hacker who made the submission, and score is the score of the submission. 

*/

SELECT B.submission_date, B.hacker_count, H.hacker_id, H.name
FROM
    /* Select the hacker with the lowest hacker_id among who have a maximum number of submissions for each day */
    (SELECT HS1.submission_date, MIN(HS1.hacker_id) AS hacker_id_min
    FROM   /* Compute the total number of submissions of each hacker on each day */
            (SELECT submission_date, S1.hacker_id, COUNT(submission_id) AS total_s
            FROM Hackers H1 JOIN Submissions S1 ON H1.hacker_id = S1.hacker_id
            GROUP BY submission_date, S1.hacker_id) AS HS1 
            LEFT JOIN
            /* Compute the total number of submissions of each hacker on each day */
             (SELECT submission_date, S1.hacker_id, COUNT(submission_id) AS total_s
            FROM Hackers H1 JOIN Submissions S1 ON H1.hacker_id = S1.hacker_id
            GROUP BY submission_date, S1.hacker_id) AS HS2 
                ON HS1.submission_date = HS2.submission_date AND HS1.total_s < HS2.total_s
    WHERE HS2.total_s IS NULL
    GROUP BY HS1.submission_date) AS A 

    JOIN 

    /* Compute the total number of unique hackers who made at least 1 submission each day */
    (SELECT submission_date, (SELECT COUNT(DISTINCT hacker_id)
                               FROM Submissions AS S2 
                               WHERE (SELECT COUNT(DISTINCT submission_date)
                                      FROM Submissions AS S3
                                      WHERE S3.hacker_id=S2.hacker_id AND 
                                            S3.submission_date < S4.submission_date) 
                                            = DATEDIFF(S4.submission_date, '2016-03-01')
                                      AND S2.submission_date = S4.submission_date) AS hacker_count     
    FROM (SELECT DISTINCT submission_date FROM Submissions) AS S4) AS B ON A.submission_date = B.submission_date
    
    JOIN Hackers H ON H.hacker_id = A.hacker_id_min
    
ORDER BY A.submission_date


/* Another solution */

SELECT submission_date, 
        
        /* Compute the total number of unique hackers who made at least 1 submission each day */
        (SELECT COUNT(DISTINCT hacker_id)
         FROM Submissions AS S1 
         WHERE (SELECT COUNT(DISTINCT submission_date)
                FROM Submissions AS S2
                WHERE S1.hacker_id = S2.hacker_id AND 
                        S2.submission_date < S3.submission_date) 
                        = DATEDIFF(S3.submission_date, '2016-03-01')
        AND S1.submission_date = S3.submission_date),
                        
        /* Select the hacker with the lowest hacker_id among who have a maximum number of submissions for each day */
        (SELECT hacker_id
         FROM Submissions AS S4
         WHERE S4.submission_date = S3.submission_date
         GROUP BY hacker_id
         ORDER BY COUNT(submission_id) DESC, hacker_id LIMIT 1) AS hacker_id_min,
        
         (SELECT Name
          FROM Hackers
          WHERE hacker_id = hacker_id_min)
        
FROM (SELECT DISTINCT submission_date FROM Submissions) AS S3


