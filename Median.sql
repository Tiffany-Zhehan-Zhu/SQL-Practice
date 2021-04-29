/*
HackerRank Question: Weather Observation Station 20
https://www.hackerrank.com/challenges/weather-observation-station-20/problem

A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
*/


SET @rowindex := -1;
 
SELECT
   ROUND(AVG(LAT_N_SORTED.LAT_N),4)
FROM
   (SELECT @rowindex:=@rowindex + 1 AS rowindex,
           LAT_N AS LAT_N
    FROM STATION
    ORDER BY LAT_N) AS LAT_N_SORTED
WHERE
LAT_N_SORTED.rowindex IN (FLOOR(@rowindex / 2) , CEIL(@rowindex / 2));
