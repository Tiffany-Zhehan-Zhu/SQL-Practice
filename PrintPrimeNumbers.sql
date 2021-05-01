/*
https://www.hackerrank.com/challenges/print-prime-numbers

Print Prime Numbers

Write a query to print all prime numbers less than or equal to 1000. 
Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).

For example, the output for all prime numbers would be: 
2&3&5&7

*/


DELIMITER $$
CREATE PROCEDURE FindPrime(IN upperlimit INT, OUT results VARCHAR(10000))
BEGIN
DECLARE num, divisor, factorscount INT;
SET num = 2;
SET results = '';

/* Loop from first prime number - 2 to the upperlimit */
WHILE (num < upperlimit) DO  
    SET divisor = 2;
    SET factorscount = 2; /* Each number at least has 2 factors, which are 1 and itself. */

    /* Loop from 2 to the number itself */
    WHILE (divisor < num) DO
        IF(num%divisor = 0) THEN 
        SET factorscount = factorscount + 1;
        END IF;
        SET divisor = divisor + 1; 
    END WHILE;

    IF (factorscount=2) THEN /* Prime numbers are those whose only factors are 1 and itself. */
    SET results = CONCAT(results, num, '&');
    END IF;

    SET num = num + 1;
END WHILE;
   
END $$
/* DELIMITER ; */

CALL FindPrime(1000, @results);
SELECT SUBSTR(@results, 1, LENGTH(@results)-1); 

