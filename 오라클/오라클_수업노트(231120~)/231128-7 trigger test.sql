-- �׽�Ʈ �ó�����
-- ������ ���� Ʈ���� ���� ���� Ȯ���ϱ�

INSERT INTO dept(deptno, dname, loc) VALUES(70, '�����', '����');

SELECT * FROM dept_copy WHERE deptno = 70;

UPDATE dept set loc = '����' WHERE deptno = 70;

DELETE FROM dept_copy WHERE deptno = 70;