/*
https://www.hackerrank.com/challenges/the-company/problem?h_r=next-challenge&h_v=zen

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. 
For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
*/

SELECT C.company_code, C.founder, COUNT(DISTINCT LM.lead_manager_code), COUNT(DISTINCT SM.senior_manager_code), COUNT(DISTINCT M.manager_code), COUNT(DISTINCT E.employee_code)
FROM Company C JOIN Lead_Manager LM ON C.company_code=LM.company_code
               JOIN Senior_Manager SM ON LM.lead_manager_code=SM.lead_manager_code
               JOIN Manager M ON SM.senior_manager_code=M.senior_manager_code
               JOIN Employee E ON M.manager_code=E.manager_code
GROUP BY C.company_code, C.founder
ORDER BY C.company_code
