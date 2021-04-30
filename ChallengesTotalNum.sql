/*
https://www.hackerrank.com/challenges/challenges/problem

Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
*/

SELECT H.hacker_id, H.name, COUNT(C.challenge_id) AS challenges_created
FROM Hackers H JOIN Challenges C ON H.hacker_id = C.hacker_id
GROUP BY H.hacker_id, H.name
HAVING 
        /* If more than one student created the same number of challenges and the count is the maximum number of challenges created.*/
        challenges_created = (SELECT COUNT(C1.challenge_id) 
                             FROM Hackers H1 JOIN Challenges C1 ON H1.hacker_id = C1.hacker_id
                             GROUP BY H1.hacker_id
                             ORDER BY COUNT(C1.challenge_id) DESC
                             LIMIT 1) 
        OR 
        /* ONLY one student created this number of challenges.*/
        challenges_created IN (SELECT challenges_total
                                  FROM (SELECT H2.hacker_id, H2.name, COUNT(C2.challenge_id) AS challenges_total 
                                        FROM Hackers H2 JOIN Challenges C2 ON H2.hacker_id = C2.hacker_id
                                        GROUP BY H2.hacker_id, H2.name) AS T2
                                  GROUP BY challenges_total
                                  HAVING COUNT(*) = 1) 
ORDER BY COUNT(C.challenge_id) DESC, H.hacker_id
