SELECT * FROM dept WHERE deptno IN (50, 51, 53);

--��ó���� ��ó��

SELECT nvl((SELECT deptno FROM dept WHERE deptno = 50), -1)
    FROM dual;