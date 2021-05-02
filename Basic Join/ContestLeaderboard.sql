/*
https://www.hackerrank.com/challenges/contest-leaderboard/problem

Contest Leaderboard

The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.

The following tables contain contest data:
Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker. 
Submissions: The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, challenge_id is the id of the challenge for which the submission belongs to, and score is the score of the submission. 
*/

SELECT hacker_id, name, SUM(maxScore)
FROM (SELECT H.hacker_id, H.name, S.challenge_id, MAX(S.score) AS maxScore
        FROM Hackers H JOIN Submissions S ON H.hacker_id = S.hacker_id 
        GROUP BY H.hacker_id, H.name, S.challenge_id) AS M
GROUP BY hacker_id, name
HAVING SUM(maxScore)>0
ORDER BY SUM(maxScore) DESC, hacker_id;
