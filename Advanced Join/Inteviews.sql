/*
https://www.hackerrank.com/challenges/interviews/problem

Inteviews 

Samantha interviews many candidates from different colleges using coding challenges and contests. 
Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.
*/


SELECT Cont.contest_id, hacker_id, name, SUM(total_submissions), SUM(total_accepted_submissions), SUM(total_views), SUM(total_unique_views) 
FROM Contests Cont JOIN Colleges Col ON Cont.contest_id = Col.contest_id 
                    JOIN Challenges Cha ON Col.college_id = Cha.college_id 
                    LEFT JOIN (SELECT challenge_id, SUM(total_views) AS total_views, SUM(total_unique_views) AS total_unique_views
                               FROM View_Stats 
                               GROUP BY challenge_id) V 
                        ON Cha.challenge_id = V.challenge_id 
                    LEFT JOIN (SELECT challenge_id, SUM(total_submissions) AS total_submissions, SUM(total_accepted_submissions) AS total_accepted_submissions
                               FROM Submission_Stats 
                               GROUP BY challenge_id) S 
                        ON Cha.challenge_id = S.challenge_id 
GROUP BY Cont.contest_id, hacker_id, name
HAVING SUM(total_submissions)>0 OR SUM(total_accepted_submissions)>0 OR SUM(total_views)>0 OR SUM(total_unique_views)>0 
ORDER BY Cont.contest_id
