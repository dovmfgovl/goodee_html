����1:�����ȣ�� 7500�� �̻��� ������� �̸��� �Ի����� �޿���
����Ͻÿ�.

�÷���: ename, hiredate, sal
������: WHERE, HAVING(GROUP BY)
���ո�: emp

SELECT ename, hiredate, sal
    FROM emp
WHERE empno >= 7500;
   

����2:�Ի��� �⵵�� 1981���� ������� ����� ����Ͻÿ�.

hiredate
XXX�� �� - ������ : decode, CASE WHEN
empno

--�ƹ� �͵� ������ ���� : �ڸ� ���� �ٸ��� �����̴�.
SELECT empno
    FROM emp
WHERE hiredate = to_date(1981,  'YYYY');

SELECT hiredate, to_date(1981, 'YYYY')
                , to_date(1981, 'YYYY')-1
    FROM emp;
    
SELECT empno, to_char(hiredate, 'YYYY')
    FROM emp
WHERE '1981' = to_char(hiredate,  'YYYY');

-- �������� - range scan - �����˻�

����3:����� �̸��� A�� ���۵Ǵ� ������� �����ȣ�� 
����Ͻÿ�.
 --��
SELECT empno
    FROM emp
WHERE ename LIKE 'A%';

--������ : � ���ڵ� �˻��� �� �ֵ��� Ȯ��!
SELECT empno, ename
    FROM emp
WHERE ename LIKE :x||'%';
 
����4:�Ի����ڰ� 1981�� 2��1�� ���� 1981�� 6��30�ϻ��̿� 
�ִ� ������� ����� ����� ����Ͻÿ�  

SELECT empno, ename, hiredate
 FROM emp
WHERE hiredate BETWEEN '1981/02/01' AND '198-06-30';

--�����˻����� ũ�ų� ����, �۰ų� ���� �� �� �����ؾ� �Ѵ� : ������(INTERSECT) 
����5:�޿��� 1000�Һ��� ũ�ų� ���� 3000�Һ��� �۰ų� ����
�������� �̸��� �޿��� ����Ͻÿ�.

SELECT ename, sal
 FROM emp
WHERE sal BETWEEN 1000 AND 3000;

--INTERSECT
SELECT deptno FROM emp
INTERSECT
SELECT deptno FROM dept;

����6:�޿��� 3000���� �ƴ� ������� ����� �̸��� ����Ͻÿ�.   

--�ƴ� ���� ã�� ���� index(����) ����� �� �ֳ�?
--�ε����� �����ϴ� ���̺�(���ؽ�Ű + rowid)�� �ִ� : �ε����� �а� ��ȸ�� �ȴ�

--<��Ʈ��>
��Ʈ���� ��Ÿ�� ������ ���õȴ� = ���� �����ȹ��� �˻����ش�
RDBMS�� ���� �����ȹ���� �����ڰ� ���� �����ȹ�� �Ǵٰ� �Ǵܵ� ��, ��Ƽ���������� �� ������ ������ �� �ִ� ������ ���

SELECT /*+index_desc(emp pk_emp) */empno
FROM emp;

SELECT empno
    FROM emp;
    
SELECT empno, ename
FROM emp;

--empno�� �ε����� �ִ�
SELECT empno, ename
    FROM emp
 WHERE empno = 7566;
 
--ename�� �ε����� ����(������ ������ �ε����� ���� ������ �ε��� ��� �Ұ�)
SELECT empno, ename
    FROM emp
 WHERE ename = 'SMITH';

--ename�� ���� index ����    
CREATE INDEX i_ename ON emp(ename ASC);

--�ε��� ���������� ename ��� �� ���� �� ��. �ε����� ������ ������� ����
SELECT ename
    FROM emp;

--�ε����� �ʿ��� ��Ȳ���� ���    
SELECT ename
    FROM emp
 WHERE ename = 'SMITH';

--'�ƴ� ��'�� ã�� ���� �ε��� ������� ����
SELECT ename
    FROM emp
 WHERE ename = '';

--�ε��� ���
SELECT ename
    FROM emp
 WHERE ename = ' ';
 
--'�ƴ� ��'�� ã�� ���� index ������� ���� : �̷� ���� ������ �ɾ� �����ȹ ���� �� index ������� ���ϵ��� ����� ����ӵ��� ������ų �� �ִ�.
SELECT empno, ename
    FROM emp
 WHERE empno != 7566;
 
--�ε��� ���
SELECT /*+rule */empno, ename
    FROM emp
 WHERE empno = 7566;
 
--�ε��� ��� : '�ƴ� ��'�� ã�µ��� ����Ѵ�
SELECT  ename
    FROM emp
 WHERE ename != 'SMITH';

--�ε��� �̻�� : ���� hiredate�� select���� ���̸�  �ε����� ������� �ʴ´�
SELECT  ename, hiredate
    FROM emp
 WHERE ename != 'SMITH';
 
 
------��--------------
SELECT empno, ename
    FROM emp
WHERE sal <> 3000;

----����-----
SELECT empno, ename, sal
    FROM emp
WHERE sal <> 3000;
 
����7:������� �μ��� �޿������ ���Ͻÿ�. 

���: avg

SELECT sal FROM emp;

SELECT sum(sal), count(sal), count(comm), avg(sal)
    FROM emp;

--���� �߻�: ���� �׷��� �׷� �Լ��� �ƴմϴ�    
SELECT deptno, avg(sal)
    FROM emp;
    
--�������� ������ �ذ��ϴ� ���
--min�� �ǹ� �ִ� ���ΰ�?
-- : �׷��Լ��� ����� �������� ������ ���� ���� ������ �ǹ̾��� �����.
-- �ǹ��ִ� ����� ���� ���� ���̶�� group by���� �߰��� ���ǹ��� ������ ����� �� �ִ�.
SELECT min(deptno), avg(sal)
    FROM emp;

--�����ذ� : GROUP BY    
SELECT deptno, avg(sal)
    FROM emp
GROUP BY deptno;
---------------------------------------------------------------------
--<��������>
�������� ������ �ƴ϶� ���������� �ְ� ���ϴ� ����� ã�ƴ޶�� �ϸ�...
��ġ �ľ�!
from���� select���̸� �ζ��κ�(���̺��ڸ�)
    �ζ��κ信�� ����� �÷����� ��Ī�̴��� �� �������� ��� ������
�������� select���̸� ��������(��)

SELECT words_vc
    FROM t_letitbe;
    
SELECT words_vc
    FROM t_letitbe
 WHERE words_vc LIKE 'Let%';
     
--����:  "A": �������� �ĺ��� - �ζ��κ信�� ����� ���̿��� �� ���������� ��� ����
SELECT decode(mod(seq_vc, 2),0, words_vc) A
    FROM t_letitbe
 WHERE A LIKE 'Let%';

--���� �ذ�: �ζ��κ� ���
SELECT A
    FROM (    
                    SELECT decode(mod(seq_vc, 2),1, words_vc) A
                        FROM t_letitbe
                )
 WHERE A LIKE 'Let%';

���� 1: temp���� ������ ���� ���� ������ row�� ã�Ƽ� �� �ݾװ� ������ �ݾ���
�޴� ������ ����� ������ ����Ͻÿ�(�������� Ȱ���� ��).

--����: ���� �׷��� �׷� �Լ��� �ƴմϴ�
SELECT max(salary), emp_name
    FROM temp;

--����� ó���� ��..   
SELECT emp_id, emp_name FROM temp
WHERE salary = 100000000;

SELECT emp_id, emp_name FROM temp
WHERE salary = (SELECT ��);

--  �������� Ȱ�� ��
SELECT emp_id, emp_name
    FROM temp
 WHERE salary = (SELECT max(salary) FROM temp);
                            

-------                          
2.temp�� �ڷḦ �̿��Ͽ� salary�� ����� ���ϰ� �̺��� ū �ݾ��� salary�� 
�޴� ������ ����� ����, ������ �����ֽÿ�.

SELECT emp_id, emp_name, salary FROM temp;

SELECT avg(salary) FROM temp;

SELECT emp_id, emp_name, salary
    FROM temp
 WHERE salary > ( SELECT avg(salary) FROM temp);
 
----
3. temp�� ���� �� ��õ�� �ٹ��ϴ� ������ ����� ������ �о���� SQL�� ����
������ �̿��� �����ÿ�.

���� : area

SELECT * FROM tdept;

SELECT dept_code FROM tdept WHERE area = '��õ';

SELECT ename, deptno FROM emp
WHERE deptno IN(10, 20);

SELECT emp_id, emp_name
    FROM temp
 WHERE dept_code IN ( SELECT dept_code FROM tdept WHERE area = '��õ');
 
 
tcom�� ���� �ܿ� Ŀ�̼��� �޴� ������ ����� �����Ǿ� �ִ�.
�� ������ ���������� select�Ͽ� �μ� ��Ī���� Ŀ�̼��� �޴�
�ο����� ���� ������ ����� ���ÿ�.

SELECT emp_id FROM temp
INTERSECT
SELECT emp_id FROM tcom;

SELECT b.dept_name
    FROM temp A, tdept b
 WHERE A.DEPT_CODE = b.dept_code
      AND A.emp_id IN(SELECT emp_id FROM tcom);
      
SELECT b.dept_name, count(A.emp_id)
    FROM temp A, tdept b
 WHERE A.DEPT_CODE = b.dept_code
      AND A.emp_id IN(SELECT emp_id FROM tcom)
GROUP BY b.dept_name;

----------------------------�ǽ��ҽ� 8-001------------------
�������� - ���� ���ڵ� �����ϱ�

SELECT cdate, amt, crate, lag(crate, 1, 9999) OVER(ORDER BY crate) AS crate_prev
    FROM test02
ORDER BY cdate;

--������ Ǯ��
SELECT * FROM test02;

SELECT ROWNUM org_no, cdate, crate, amt FROM test02;

SELECT ROWNUM copy_no, cdate, crate, amt FROM test02;

SELECT *
    FROM (
                    SELECT ROWNUM org_no, cdate, crate, amt FROM test02
                )A,
                (
                    SELECT ROWNUM copy_no, cdate, crate, amt FROM test02
                )b
 WHERE A.org_no-1 = b.copy_no;
 
 SELECT A.cdate, A.amt, b.crate
                , to_char((A.amt*b.crate), '9,999,999,999')||'��' AS "��ȭ�ݾ�"
    FROM (
                    SELECT ROWNUM org_no, cdate, crate, amt FROM test02
                )A,
                (
                    SELECT ROWNUM copy_no, cdate, crate, amt FROM test02
                )b
 WHERE A.org_no-1 = b.copy_no;

-------����� ���� �Լ� �����--------------231123-2-------------------------- 
SELECT mod(5, 2) FROM dual;

SELECT func_crate('20010906') 
    FROM dual;    
    
    
-----����--------Ǯ�̰���------------------------------------------------------------------------------
 SELECT ROWNUM rno FROM dept
 WHERE ROWNUM  =2;
 
 SELECT indate_vc FROM t_orderbasket;
 
  SELECT indate_vc FROM t_orderbasket
  GROUP BY indate_vc;
 
  SELECT indate_vc, min(qty_nu) FROM t_orderbasket
  GROUP BY indate_vc;
 
SELECT ename FROM emp
GROUP BY ename;

SELECT deptno FROM emp
GROUP BY deptno;

  SELECT indate_vc FROM t_orderbasket
  GROUP BY indate_vc
  UNION ALL
  SELECT '�Ѱ�' FROM dual;
  
  54 ���� 108���� �Ǿ���.
  54���� ��¥�� ��꿡 �������� ������ 54���� �Ѱ� �ϳ��� ���´�
  
   SELECT indate_vc FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3); 
   
   SELECT decode(b.rno,1, indate_vc,2,'�Ѱ�') FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3) b;    
   
     SELECT decode(b.rno,1, indate_vc,2,'�Ѱ�') FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3) b
   GROUP BY  decode(b.rno,1, indate_vc,2,'�Ѱ�') ;
   
      SELECT decode(b.rno,1, indate_vc,2,'�Ѱ�'), sum(qty_nu) FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3) b
   GROUP BY  decode(b.rno,1, indate_vc,2,'�Ѱ�') ;  
   
      SELECT decode(b.rno,1, indate_vc,2,'�Ѱ�'), sum(qty_nu) ||'EA' AS "�Ǹż���" FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3) b
   GROUP BY  decode(b.rno,1, indate_vc,2,'�Ѱ�') ;     
   
      SELECT decode(b.rno,1, indate_vc,2,'�Ѱ�')
                 , sum(qty_nu) ||'EA' AS "�Ǹż���" 
         FROM t_orderbasket,
                   (SELECT ROWNUM rno FROM dept 
                     WHERE ROWNUM <3) b
               GROUP BY  decode(b.rno,1, indate_vc,2,'�Ѱ�') ;    
               
      SELECT decode(b.rno,1, indate_vc,2,'�Ѱ�') AS "�Ǹų�¥"
                 , sum(qty_nu) ||'EA' AS "�Ǹż���" 
         FROM t_orderbasket,
                   (SELECT ROWNUM rno FROM dept 
                     WHERE ROWNUM <3) b
               GROUP BY  decode(b.rno,1, indate_vc,2,'�Ѱ�') 
            ORDER BY  decode(b.rno,1, indate_vc,2,'�Ѱ�') ;    
            
      SELECT decode(b.rno,1, indate_vc,2,'�Ѱ�') AS "�Ǹų�¥"
                 , sum(qty_nu) ||'EA' AS "�Ǹż���" 
                 ,sum(qty_nu*price_nu) AS "�Ǹűݾ�"
         FROM t_orderbasket,
                   (SELECT ROWNUM rno FROM dept 
                     WHERE ROWNUM <3) b
               GROUP BY  decode(b.rno,1, indate_vc,2,'�Ѱ�') 
            ORDER BY  decode(b.rno,1, indate_vc,2,'�Ѱ�') ;   


SELECT decode(b.rno, 1, indate_vc, 2, '�Ѱ�', 3, '�Ұ�')
                , decode(b.rno, 3, gubun_vc||'��', 1, gubun_vc)
    FROM t_orderbasket,
                (SELECT ROWNUM rno FROM dept 
                  WHERE ROWNUM < 4) b
 GROUP BY decode(b.rno, 1, indate_vc, 2, '�Ѱ�', 3, '�Ұ�')
                                       , decode(b.rno, 3, gubun_vc||'��', 1, gubun_vc)
 ORDER BY decode(b.rno, 1, indate_vc, 2, '�Ѱ�', 3, '�Ұ�');
 
 
--���� ��--
SELECT decode(b.rno, 1, indate_vc, 2, '�Ѱ�', 3, '�Ұ�') AS "�Ǹų�¥"
                , decode(b.rno, 3, gubun_vc||'��', 1, gubun_vc) AS "��ǰ����"
                , sum(qty_nu) AS "�ǸŰ���"
                , sum(qty_nu*price_nu) AS "�ǸŰ���"
    FROM t_orderbasket,
                (SELECT ROWNUM rno FROM dept 
                  WHERE ROWNUM < 4) b
 GROUP BY decode(b.rno, 1, indate_vc, 2, '�Ѱ�', 3, '�Ұ�')
                   , decode(b.rno, 3, gubun_vc||'��', 1, gubun_vc)
 ORDER BY decode(b.rno, 1, indate_vc, 2, '�Ѱ�', 3, '�Ұ�');
 
 --
 
 SELECT ename
    FROM emp;
    
 SELECT ename
    FROM emp
GROUP BY ename;

 SELECT deptno
    FROM emp
GROUP BY deptno;

--group by�� ����� �ƴ� ename�� ������ ����� ������ ���� 
 SELECT deptno, ename
    FROM emp
GROUP BY deptno, ename;


-----------------����(231122)-----------����------
SELECT
      sum(decode(JOB,'CLERK',sal)) clerk_sal
     ,sum(decode(JOB,'SALESMAN',sal)) salesman_sal
     ,sum(decode(JOB, 'CLERK', NULL, 'SALESMAN', NULL, sal)) etc
  FROM scott.emp A, scott.dept b
 WHERE A.deptno = b.deptno  
       
SELECT 
      nvl(decode(b.NO, '1', dname), '�Ѱ�') dname
     ,sum(clerk) clerk
     ,sum(manager) manager
     ,sum(etc) etc
     ,sum(dept_sal) dept_sal
  FROM (
        SELECT bb.dname, clerk, manager, etc, dept_sal
          FROM (
                SELECT deptno
                      ,sum(decode(JOB, 'CLERK', sal)) clerk
                      ,sum(decode(JOB, 'MANAGER', sal)) manager
                      ,sum(decode(JOB, 'CLERK', NULL, 'MANAGER', NULL, sal)) etc
                      ,sum(sal) dept_sal 
                 FROM emp A
                GROUP BY deptno
               )aa, dept bb
         WHERE aa.deptno = bb.deptno  
       )A,
       (SELECT '1' NO FROM dual --NO�� alias�� 1���� ������ ����: union all���� ������ alias�� ù��° ���� ������ ����ȴ�
        UNION ALL
        SELECT '2' FROM dual 
       )b     
       GROUP BY decode(b.NO, '1', dname)
ORDER BY dname  

�����ϸ� ���̺��� �� ���� �о ó���Ѵ�
-> ����� ���� ���δ�(ī��θ�Ƽ�� ���δ�) : �ζ��κ� �Ǵ� GROUP BY(������ �ϱ� �� �̸� �׷��� �Ѵ� - 14���� 3������ �پ��)
-> ���� �Ѵ�(�׷����� �ϸ鼭 �׷��Լ��� �ʿ��� �κ�(sum(decode����))�� �ִٸ� ���� �ص� �ȴ�.)
->  FROM emp A /   )aa, dept bb : �� ������ ���̺��� �о���
        - �� ������ �߳�? : �μ���ȣ�� �ƴ϶� �μ����� ����ϴ� ���� �������̱� �����̴�.
-> �������� ��� : ������ ���� - īŸ�þȰ� - 2����� ������

SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;

-> �Ѱ踦 �ְ� ������ deptno�̴�(Ÿ���� number) - �׷��� �Ѱ踦 ���� �� ��.
    - �Ѱ� �κ��� ���� ����Ͽ� ���������� ó���ϸ� ���� ������ �� �� �а� �ȴ�. 
    - GROUP BY �ϱ� ���� ���� JOIN �Ѵ�(decode(dommy.rno, 1, dname, 2, '�Ѱ�')
--14���� 3������ ���̱� ����
--�μ����� ��� ���� ���� ����
--GROUP BY (decode(b.no, '1', dname)

SELECT 
    (decode(b.NO, 1, A.dname, 2, '�Ѱ�'))
     , clerk
     , manager
     , etc
     , dept_sal
  FROM (
        SELECT bb.dname, clerk, manager, etc, dept_sal
          FROM (
                SELECT deptno
                      ,sum(decode(JOB, 'CLERK', sal)) clerk
                      ,sum(decode(JOB, 'MANAGER', sal)) manager
                      ,sum(decode(JOB, 'CLERK', NULL, 'MANAGER', NULL, sal)) etc
                      ,sum(sal) dept_sal 
                 FROM emp A
                GROUP BY deptno
               )aa, dept bb
         WHERE aa.deptno = bb.deptno  
       )A,
       (SELECT '1' NO FROM dual
        UNION ALL
        SELECT '2' FROM dual 
       )b     
       
SELECT 
    (decode(b.NO, 1, A.dname, 2, '�Ѱ�'))
  FROM (
        SELECT bb.dname, clerk, manager, etc, dept_sal
          FROM (
                SELECT deptno
                      ,sum(decode(JOB, 'CLERK', sal)) clerk
                      ,sum(decode(JOB, 'MANAGER', sal)) manager
                      ,sum(decode(JOB, 'CLERK', NULL, 'MANAGER', NULL, sal)) etc
                      ,sum(sal) dept_sal 
                 FROM emp A
                GROUP BY deptno
               )aa, dept bb
         WHERE aa.deptno = bb.deptno  
       )A,
       (SELECT '1' NO FROM dual
        UNION ALL
        SELECT '2' FROM dual 
       )b
 GROUP BY  (decode(b.NO, 1, A.dname, 2, '�Ѱ�'));
 
 SELECT 
    (decode(b.NO, 1, A.dname, 2, '�Ѱ�'))
     ,sum(clerk) clerk
     ,sum(manager) manager
     ,sum(etc) etc
     ,sum(dept_sal) dept_sal
  FROM (
        SELECT bb.dname, clerk, manager, etc, dept_sal
          FROM (
                SELECT deptno
                      ,sum(decode(JOB, 'CLERK', sal)) clerk
                      ,sum(decode(JOB, 'MANAGER', sal)) manager
                      ,sum(decode(JOB, 'CLERK', NULL, 'MANAGER', NULL, sal)) etc
                      ,sum(sal) dept_sal 
                 FROM emp A
                GROUP BY deptno
               )aa, dept bb
         WHERE aa.deptno = bb.deptno  
       )A,
       (SELECT '1' NO FROM dual
        UNION ALL
        SELECT '2' FROM dual 
       )b
 GROUP BY  (decode(b.NO, 1, A.dname, 2, '�Ѱ�'))
 ORDER BY  (decode(b.NO, 1, A.dname, 2, '�Ѱ�'));