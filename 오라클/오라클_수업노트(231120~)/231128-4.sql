SELECT * FROM dept WHERE deptno IN (50, 51, 53);

--傈贸府客 饶贸府

SELECT nvl((SELECT deptno FROM dept WHERE deptno = 50), -1)
    FROM dual;