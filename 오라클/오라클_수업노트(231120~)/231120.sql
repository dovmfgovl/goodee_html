--DML : ������ ���۾�

SELECT * FROM TEMP;

SELECT * FROM TDEPT;

SELECT
                ENAME
    FROM EMP;
 
 --���̺��� ����̺� �� �� �ε��� ���� �д´�
 --���̺��� ������ ���� �ʰ� �ε��� ���������ε� ��ȸ��  
    
 --���̺��� ���������� �ʰ� 
 
   SELECT
                EMPNO
    FROM EMP; 
    
  SELECT
                EMPNO, ROWID RID
    FROM EMP; 
    
  SELECT ENAME
        FROM EMP
    WHERE ROWID = 'AAARE8AAEAAAACTAAA';
    
  SELECT
                EMPNO
    FROM EMP
    ORDER BY EMPNO DESC; 
    
-- ��Ƽ�������� ������ �����ϴ� ������ ���� ã�ƿ´�
-- ����ó�� ����, Ŭ������ ����

SELECT
                ENAME
    FROM EMP
    
    ORDER BY EMPNO DESC; 

-- ���̺� ��Ű��
--pk, ������Ÿ��, �ε���, ��������, �������� ��ġ
-- DML(SELECT - �Ƿ����� ���� �κ�) - ���ǰ˻� ����
-- ��Ƽ�������� ���� ��
-- ���� ������ �ִ�. - �ӵ����̰� ����
--FROM���� ���̺��� ���� ��(���� - ��ü�𵨼���) �� �� �ִ� : ���� ���� �ҷ�? - ������ ���� �ӵ� ���� ��
--ROWID�� �ִ� - 18�ڸ�

--<ROWID ����>
--DBMS�� ������ �ִ� ��� ������ ������ ������ �ĺ��ڴ�

SELECT
                 deptno, dname, loc
  FROM emp;
  
  --īŸ�þ� �� : ������ �����Ͽ� ����, �Ұ�, �� ���� �� ���
  --�� �����ΰ�? �ϳ��� ���� �Ѱ迡�� �� ��, �Ұ迡�� �� ��, �� �� ��
  --���� ���� 4�� ���Ǿ�� �ϴ� ���.. ���
  -- �� ���� ����� �ٹ��� �� �ִ� �μ��� ������ ��� ��µ� 
  SELECT
                dept.dname, emp.deptno, dept.deptno
  FROM emp, dept;
  
  --������ ���� ���ԵǾ� �־� ��������� ��(�ǹ̾��� �����Ͱ� ���� �� �ִ�)
  -- -> Natural Join ���!
  
  --1:n�� ���迡 �ִ� - �̷� ���
  SELECT
                dept.dname, emp.deptno, dept.deptno
  FROM emp, dept
  WHERE emp.deptno = dept.deptno;
  
  DELETE FROM dept WHERE deptno IN(60, 80, 90);
  
  COMMIT;
  
  SELECT * FROM dept;
  
  ROLLBACK;
  
  -- select �ڿ��� �÷����� �´� - ���� ���� �� �� �ִ� - �������� �ĺ���: �÷����� ������
  --select�� �ڿ� ����ó���� �����ϴ�.
  
  SELECT 1+2, 2*3, 10/2 FROM dual;
  
  --�׷��ռ� : max, min, avg()
  --�� �׷��Լ���� �ұ�?
  
  --�÷����� ���� �ڸ��� �Լ��� ��ø�ؼ� ����� �� �ִ�.--�׷��ռ� : max, min, avg()
  --�� �׷��Լ���� �ұ�?
  SELECT count(empno) FROM emp;
  
  SELECT count(comm) FROM emp;
  
  SELECT max(sal), min(sal) FROM emp;
  
  --���� �׷��Լ��� �ƴմϴ�.
  SELECT max(sal), min(sal), ename FROM emp;
  
  --from�� �ڿ��� ����(select���� ������ - �ζ��κ� - �߿���)�� �´�.
  
  -- where�� : ���ǰ˻� �� �����
  --where deptno = 10;
  
  
--  1.�� �޿��� ������ 18�� ������ Ȧ�� �޿��� ������ 1/18�� ���޵ǰ�, ¦���޿��� ������ 2/18�� ���޵ȴٰ� �������� �� Ȧ�� �ް� ¦�� �޿� ���� �ݾ��� ��Ÿ���ÿ�.
SELECT salary FROM temp;

SELECT salary/18, salary*2/18 FROM temp;

SELECT salary/9 FROM temp;

--alias�� ""�ȿ� �־��ִ°� ����. "" �־����� �ʾ��� ���� '�μ� �̸�' �� ���� ������ �־ �� �� 
SELECT dname "�μ���1", dname AS "�μ���2", dname �μ���3 FROM dept;

SELECT salary/18 AS "Ȧ���ޱ޿�", salary*2/18 AS "¦���ޱ޿�"FROM temp;

--�Ҽ��� �� ��° �ڸ����� �ݿø��Ͽ� �Ҽ��� ù° �ڸ����� ���
-- -1�� ������ ���� ������ �ڸ����� �ݿø��Ͽ� ���
SELECT round(12345.6789, 1), round(12345.6778, -1), round(12345.6789, 0), round(109, -1) FROM dual;

SELECT round(salary/18, -1) AS "Ȧ���ޱ޿�", round(salary/18, 0)
                , round(salary*2/18, -1) AS "¦���ޱ޿�"
  FROM temp;

--����Ŭ������ ����ȯ �Լ��� �ִ� : ������ -> ���������� �ٲ۴�
--����Ŭ �Լ��� �Ķ���͵� �ְ� ���ϰ��� �ִ�  (��� ���������� ����)
SELECT sysdate FROM dual;

SELECT sysdate, to_char(sysdate, 'YYYY-MM-DD')
                , to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS AM')
                 , to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM')
                 , to_char(sysdate, 'day')
    FROM dual;

--Į������ �����ϸ� ���� ����
 SELECT 1,2,3,4,5 FROM dual;
 
 --�������� ����ϸ� ���� ����
 SELECT 1 FROM dual
 UNION ALL
SELECT 2 FROM dual
 UNION ALL
SELECT 3 FROM dual;
--���η� �Ǿ� �ִ� ���� ���ο� ����� �� �ִ�.
--���ο� �ִ� ���� ���ο� ����� �� �ִ�.

--�ߺ����� ������
--union all : �� ���� �״�� ����. �ߺ����� ����.
--union : �ߺ� ����. ����(���� ���ؼ� �ߺ������ϰ��� �����ϴ� ��. �׷��� ���� - 2�� ����)
--union���� union all�� �� ó�� �ӵ� ������ : ������ ���� �ʰ� ����ϱ� ������

--��� ����) �����ϱ�, ��� 1�� ����, ����(���), ������
SELECT deptno FROM dept
UNION ALL
SELECT deptno FROM emp;

SELECT deptno FROM dept
UNION
SELECT deptno FROM emp;

--������
SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;

SELECT deptno, dname FROM dept
MINUS
SELECT deptno, ename FROM emp;

SELECT deptno, 1 FROM dept
MINUS
SELECT deptno, 1 FROM emp;

SELECT deptno, 1 FROM dept
MINUS
SELECT deptno, 2 FROM emp;

--������
SELECT deptno FROM dept
INTERSECT
SELECT deptno FROM emp;

-- || : concat
 SELECT  TO_CHAR(round(salary/18,-1), '999,999,999')||'��' AS "Ȧ���ޱ޿�"
           ,  round(salary*2/18,-1)||'��' AS "¦���ޱ޿�" 
  FROM temp;  
  
--���ǿ��� 
--�����ǰ� : ==, in����(or��)
--���������� �ִ� : between A and B

--2.������ ���� �� �޿��� ����� 10������ ���޵ȴٸ�(¦������ 20����)���� ������ ��� �ٲ��� �ۼ��� ���ÿ�.
SELECT salary/9, (salary/9+100000)*6 AS "Ȧ���ޱ޿�", (salary/9+200000)*6 AS "¦���ޱ޿�" FROM temp;

 SELECT  TO_CHAR(round(salary/18,-1)+100000, '999,999,999')||'��' AS "Ȧ���ޱ޿�"
           , TO_CHAR(round(salary*2/18,-1)+200000, '999,999,999')||'��' AS "¦���ޱ޿�" 
  FROM temp;  
  
  SELECT  TO_CHAR(123456789, '999,999')
           ,  TO_CHAR(123456789, '999,999,999')
  FROM dual;  


--3.TEMP ���̺��� ��̰� NULL �� �ƴ� ����� ������ �о���ÿ�.
SELECT  EMP_NAME, hobby  FROM temp WHERE hobby IS NOT NULL;

--�츮ȸ�� ��� �߿��� �μ�Ƽ�긦 ���� �ʴ� ����� �̸��� �����ȣ�� ����Ͻÿ�.
SELECT empno, ename FROM emp;

SELECT empno, ename FROM emp
WHERE comm > 0;

SELECT empno, ename FROM emp
WHERE comm IS NULL;

SELECT empno, ename FROM emp
WHERE comm IS NOT NULL
    AND comm > 0;

SELECT empno, ename FROM emp
WHERE comm IS NOT NULL
    OR comm > 0;
    
SELECT empno, ename FROM emp WHERE comm IS NOT NULL
UNION
SELECT empno, ename FROM emp WHERE comm > 0;

--��� �Ǵ� ������ ���
SELECT emp_name, hobby
     FROM temp
WHERE hobby IN('���', '����');

--hobby�� null �Ǵ� ����� ���
SELECT emp_name, hobby
       FROM temp
 WHERE hobby IN('���', NULL);
 
SELECT emp_name, hobby
       FROM temp
 WHERE hobby = '���'
        OR hobby IS NULL;
        
--hobby�� null �Ǵ� '����' ��ο� ������ �ʴ� ��츦 ���Ͻÿ�

--not in(null)�� ����ִٸ� �ƹ� ���� ��µ��� ����.
SELECT emp_name, hobby
       FROM temp
 WHERE hobby NOT IN('����', NULL);

SELECT emp_name, hobby
    FROM temp
 WHERE hobby <> '����' 
        AND hobby IS NOT NULL;

--4.TEMP ���̺��� ��̰� NULL�� ����� ��� HOBBY�� ���������̶�� ���� ġȯ�Ͽ� �������� �������� �״�� ���� �о���ÿ�.
--alias�� ���� �����̼�, ���ڿ��� �̱� �����̼�!!!!!!!!!!!!
SELECT emp_name, nvl(hobby, '����') FROM temp;

SELECT ename, comm, nvl(comm, 0) FROM emp;

--5.TEMP�� �ڷ� �� HOBBY�� ���� NULL�� ����� ����ꡯ���� ġȯ���� �� HOBBY�� ������� ����� ������ �������� ������ �ۼ��Ͻÿ�.
SELECT emp_name, hobby FROM temp
WHERE nvl(hobby, '���') = '���';

SELECT ename, empno FROM emp
WHERE empno = 7566;

--�����ͺ��̽������� Ÿ���� ������ �ʾҾ �ڵ����� ������ (7566�� �ѹ������� VARCHAR ���·� ��� ������ ó������)
SELECT ename, empno FROM emp
WHERE empno = '7566';

SELECT ename, empno FROM emp
WHERE empno = to_number( '7566');

--6.TEMP�� �ڷ� �� EMP_ID�� EMP_NAME�� ���� �������,���������� ǥ�õǾ� DISPLAY�ǵ��� COLUMN ALLIAS�� �ο��Ͽ� SELECT �Ͻÿ�.
SELECT emp_id AS "���", emp_name AS "����" FROM temp;

--7.TEMP�� �ڷḦ ���� ��(LEV)�� ASCENDING�ϸ鼭 ��������� �ٽ� ��� ������
--DESCENDING�ϰ� �ϴ� ORDER BY�ϴ� ������ ����� ���ÿ�.
