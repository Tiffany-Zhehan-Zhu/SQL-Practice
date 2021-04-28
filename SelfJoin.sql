/*
Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer, and the bus no. and company for the second bus.
*/

SELECT c.num, c.company, c.endstop AS transferstop, l.num, l.company
FROM (SELECT a.num, a.company, stopa.name AS startstop, stopb.name AS endstop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart') c JOIN 
(SELECT a.num, a.company, stopa.name AS startstop, stopb.name AS endstop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopb.name='Lochend') l 
ON (c.endstop=l.startstop)
