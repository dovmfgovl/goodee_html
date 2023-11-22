SELECT empno, ename FROM emp;

-- ���ĵ�
SELECT empno FROM emp;

-- ���� �� ��
SELECT ename FROM emp;

--���� �ǰ� �� �ǰ��� ������ ����?
--  �����ȹ�� ���÷� ���� �ε����� ��ĵ�ؼ� ���� ����Ͽ���.
--  �ε����� ���� ������ֳ�? - �ڵ����� ������
--   �ڵ����� ���� �� ������ ���������� �� 

-- hint�� : �ּ�ó�� ���� ����
SELECT
                /*+ ALL_ROWS */ empno
     FROM emp;
     
SELECT /*+index_desc(emp pk_emp) */empno FROM emp;

SELECT ename FROM emp
ORDER BY ename desc;

--------

-- natural join: ���� ���տ� �ִ� �͸� ����
SELECT empno, ename, dept.dname
    FROM emp, dept
WHERE emp.deptno = dept.deptno;

--��Ʈ���� ���� ��Ƽ���������� �����ڰ� �����ϴ� �����ȹ�� ������ �� �ִ�. ���� ��Ÿ�� ������ ���õȴ�.
SELECT /*+ rule */ *
    FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- �ؽ����� ����� �� ���̺��� ���� ��°�� �о ���� ���� ���� �ڿ� ������ ���ذ��� ����Ѵ�.

SELECT rowid rid, ename FROM emp;

--ROWNUM: ��ȸ ����� ���� ������ �ű� �� �����
SELECT ROWNUM rno, ename FROM emp;

SELECT ROWNUM rno, empno, ename
    FROM (
                    SELECT empno, ename FROM emp
                    ORDER BY hiredate desc
                );
                
                
--------------------------------------
-- �׷��Լ�----------------
SELECT sum(sal)
    FROM emp;
    
--ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
--������ �̸��� ����� �޶�°��� �� �� ���� ������ ���� �߻�
SELECT sum(sal), ename
    FROM emp;
    
-- -> ���� ����ϰ� �ʹٸ� max or min �߰� : ��, sum�� ��������. W�̱⿡ max �� ��  WARD�� ��µǴ� ���� ��
-- ename�� max�� ���� �� �������� ������ ���ϱ� �����̴�. ���� �װ� ��
SELECT sum(sal), max(ename)
    FROM emp;    
    
SELECT count(comm), max(ename)
    FROM emp;
    
SELECT count(comm), ename
    FROM emp;
 
-- �� ������ GRUOP BY�� �ذ�---------------
--ORA-00979: GROUP BY ǥ������ �ƴմϴ�. 
--select���� ���� �÷��� GROUP BY������ ����� �� ����.
SELECT count(comm), ename
    FROM emp
GROUP BY deptno;

--�� ���� �ذ�
SELECT count(comm), ename
    FROM emp
GROUP BY ename;

SELECT seq_vc
    FROM t_letitbe
WHERE seq_vc > 3;

--ORA-00904: "MNO": �������� �ĺ���
--  alias�� where������ �� �� ����. ���տ��� �����ϴ� �÷��� �ƴϱ� �����̴�.
SELECT mod(seq_vc, 2) mno
    FROM t_letitbe
WHERE mno > 3;

--<�ذ���>
--1) where������ mod(seq_vc, 2) ���� �־� ���
SELECT mod(seq_vc, 2) mno
    FROM t_letitbe
WHERE mod(seq_vc, 2) = 1 ;

-- 2) �ζ��κ�
--  from���� ���� ������ ���̺��̴�.
SELECT mno
    FROM (
                    SELECT mod(seq_vc, 2) mno
                        FROM t_letitbe
                )
WHERE mno = 1;

-- <max�� �Ϲ� �÷��� �Բ� ������� ���ϴ� �������� ������ �ذ��ϴ� �� ���� ���>----
1) �ʵ� �׷��Լ� ������
2) GROUP by���� �ʵ� ��� : ��, ȿ���� ���� ������. - �׷� ��?

SELECT deptno FROM emp;

--�Ʒ� ���� ���� ��� : �ߺ� ����
SELECT DISTINCT(deptno) FROM emp;

SELECT deptno FROM emp
GROUP BY deptno;
----

--�̸��� ���: �ߺ��� ������ �ߺ����Ŵ� ���� �ʴ´�. ��, ���� �� �ߺ����� �ִ� ã�� ���̱� ������ �����Ͽ� ��µȴ�
SELECT ename FROM emp;

SELECT DISTINCT(ename) FROM emp;

SELECT ename FROM emp
GROUP BY ename;

SELECT deptno, sum(sal), count(sal), max(sal), min(sal), avg(sal)
    FROM emp
GROUP BY deptno;

------------------------------------------------------------------------------
--------------���ǹ�-------------------------
SELECT ... FROM �� ���̿� ���ǹ��� ����� �� �ִ�
1) decode : ũ��, �۴ٴ� ���� �� ����.

SELECT decode(sign(1-2), 1,'�տ� ���ڰ� ũ��', -1,'�ڿ� ���ڰ� ũ��', 0, '����') FROM dual;

SELECT greatest(1,5,3), least(1,5,3) FROM dual;

2) case��

SELECT deptno, 
       CASE deptno
         WHEN 10 THEN 'ACCOUNTING'
         WHEN 20 THEN 'RESEARCH'
         WHEN 30 THEN 'SALES'
         ELSE 'OPERATIONS'
       END AS "Dept Name"
  FROM dept;
        
        
--------------------------------------�ǽ��ҽ� 03-001,002-------------------------------
temp�� �ڷḦ salary�� �з��Ͽ� 30,000,000���ϴ� 'D',
30,000,000 �ʰ� 50,000,000���ϴ� 'C'
50,000,000 �ʰ� 70,000,000���ϴ� 'B'
70,000,000 �ʰ��� 'A'��� ����� �з��Ͽ� ��޺� �ο�����
�˰� �ʹ�.

SELECT CASE WHEN salary > 70000000 THEN 'A' END
    FROM temp;
   
SELECT
                CASE WHEN salary > 70000000 THEN 'A' END AS A
                , CASE WHEN salary BETWEEN 50000001 AND 70000000 THEN 'B' END AS b
                , CASE WHEN salary BETWEEN 30000001 AND 50000000 THEN 'C' END AS c
                , CASE WHEN salary <= 30000000 THEN 'D' END AS d
                , count(*)
   FROM temp
GROUP BY CASE WHEN salary > 70000000 THEN 'A' END
                , CASE WHEN salary BETWEEN 50000001 AND 70000000 THEN 'B' END
                , CASE WHEN salary BETWEEN 30000001 AND 50000000 THEN 'C' END
                , CASE WHEN salary <= 30000000 THEN 'D' END;
   
SELECT
                 CASE WHEN salary <= 30000000 THEN 'D'
                 WHEN salary <=50000000 THEN 'C'
                 WHEN salary <=70000000 THEN 'B'
                 WHEN salary > 70000000 THEN 'A'
                 END c
  FROM temp;
  
SELECT
                 CASE WHEN salary <= 30000000 THEN 'D'
                 WHEN salary <=50000000 THEN 'C'
                 WHEN salary <=70000000 THEN 'B'
                 WHEN salary > 70000000 THEN 'A'
                 END c,
                 count(*)
    FROM temp
 GROUP BY CASE WHEN salary <= 30000000 THEN 'D'
                 WHEN salary <=50000000 THEN 'C'
                 WHEN salary <=70000000 THEN 'B'
                 WHEN salary > 70000000 THEN 'A'
                 END;
   
SELECT
                count(CASE WHEN salary > 70000000 THEN 'A' END) AS A
                , count(CASE WHEN salary BETWEEN 50000001 AND 70000000 THEN 'B' END) AS b
                 , count(CASE WHEN salary BETWEEN 30000001 AND 50000000 THEN 'C' END) AS c
                  , count(CASE WHEN salary <= 30000000 THEN 'D' END) AS d
   FROM temp;
   
 -- 4���� �ǽ�����
 -- �Ǹų�¥, �ǸŰ���, �ǸŰ��� ��� + �Ѱ����
 --decode�� from���� ������ ��𼭵� ��� ����!!!!!
 --�м��Լ� ����� �����Ͽ� �����ϱ�
-- CREATE TABLE T_ORDERBASKET
--(
--SEQ_NU    NUMBER,
--INDATE_VC VARCHAR2(8),
--GUBUN_VC VARCHAR2(10),
--NAME_VC VARCHAR2(20),
--QTY_NU NUMBER,
--PRICE_NU NUMBER
--)

SELECT * FROM t_orderbasket;

--���� �������� ��ǥ�� ���ϴ� ������ ����?
-- ����ľ� - ������ǰ ä���� �Ѵ�
SELECT count(qty_nu), sum(qty_nu)
    FROM t_orderbasket;
    
--�Ǹŵ� ������ �ݿ����� �ʾҴ� : �ܰ��� �ݿ��� ���̴�. ���� �ݿ����� ����
SELECT sum(price_nu)
    FROM t_orderbasket;

SELECT sum(price_nu*qty_nu)
    FROM t_orderbasket;
    
SELECT deptno
    FROM emp
 GROUP BY deptno;

�μ��� - GROUP BY
�б⺰
�ݱ⺰
�⵵��

��¥����....

SELECT indate_vc
    FROM t_orderbasket
 GROUP BY indate_vc;

-- �ο츦 ���� �� ���ϴ� ����� �ƴϴ�
SELECT indate_vc, sum(qty_nu), count(qty_nu)
    FROM t_orderbasket
 GROUP BY indate_vc;
 
SELECT indate_vc, sum(qty_nu*price_nu)
    FROM t_orderbasket
 GROUP BY indate_vc;
 
SELECT sum(A.tot)
    FROM (
                    SELECT sum(qty_nu*price_nu) tot
                        FROM t_orderbasket
                     GROUP BY indate_vc
                )A;

SELECT indate_vc FROM t_orderbasket
GROUP BY indate_vc;  

--1���� ��¥�� ����� �� ����ϰ�, 2���� �Ѱ� ���� �� ��갪���� ����Ѵ�.
--1)
SELECT indate_vc FROM t_orderbasket,
(SELECT ROWNUM rno FROM dept WHERE ROWNUM <3);

--2)
SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual;
--2)���� 1)�� �� ȿ����!

--2) ����� �ð�ȭ! Ȯ���غ���
SELECT indate_vc FROM t_orderbasket,
(
SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual
);

--3) �Ѱ� ���ϱ�
SELECT decode(A.rno, 1, indate_vc,2, '�Ѱ�') FROM t_orderbasket,
(
SELECT 1  rno FROM dual
UNION ALL
SELECT 2 FROM dual
)A

SELECT decode(A.rno, 1, indate_vc,2, '�Ѱ�') FROM t_orderbasket,
(
SELECT 1  rno FROM dual
UNION ALL
SELECT 2 FROM dual
)A
GROUP BY decode(A.rno, 1, indate_vc,2, '�Ѱ�');

--2�� �ο츦 �߰��� ������ 1���� �� ��¥�� ��꿡�� ����ϰ� 2���� �� �Ѱ� ��� �� ����ϰڴ�
--indate_vc�� varchar�� Ÿ���� �����ؼ� ����. qty_nu�� ������ Ÿ���� �޶� ���� ��
SELECT decode(A.rno, 1, indate_vc,2, '�Ѱ�')
    FROM t_orderbasket,
                (
                SELECT 1  rno FROM dual
                UNION ALL
                SELECT 2 FROM dual
                )A
GROUP BY decode(A.rno, 1, indate_vc,2, '�Ѱ�')
ORDER BY decode(A.rno, 1, indate_vc,2, '�Ѱ�');

--ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
--�׷���̿� ���� ���� �Ϲ� �÷��� �� �� ����.
SELECT decode(A.rno, 1, indate_vc,2, '�Ѱ�'), qty_nu
    FROM t_orderbasket,
                (
                SELECT 1  rno FROM dual
                UNION ALL
                SELECT 2 FROM dual
                )A
GROUP BY decode(A.rno, 1, indate_vc,2, '�Ѱ�')
ORDER BY decode(A.rno, 1, indate_vc,2, '�Ѱ�');

--�ذ� + ���� ��
-- rollup �������� ���� RDBMS���...!! �ᱹ �̷��� ����ȭ�ؼ� ����ؾ� �Ѵ�.
SELECT decode(A.rno, 1, indate_vc,2, '�Ѱ�'), sum(qty_nu), sum(qty_nu*price_nu)
    FROM t_orderbasket,
                (
                SELECT 1  rno FROM dual
                UNION ALL
                SELECT 2 FROM dual
                )A
GROUP BY decode(A.rno, 1, indate_vc,2, '�Ѱ�')
ORDER BY decode(A.rno, 1, indate_vc,2, '�Ѱ�');

SELECT max(ename), min(ename) --����(parsing)���� ������ �ܼ��� ���ϱ� ���ؼ� �ǹ̾��� ���
    FROM emp
GROUP BY deptno;

SELECT decode(JOB, 'clerk', sal), decode(JOB, 'saleman', sal)
                , decode(JOB

SELECT decode(b.rno,1,indate_vc,2,'�Ѱ�') AS "�Ǹų�¥"
               , sum(qty_nu)||'��' AS "�ǸŰ���"
               , sum(qty_nu*price_nu)||'��' AS "�ǸŰ���"
FROM t_orderbasket,
        (SELECT ROWNUM rno
        FROM dept
        WHERE ROWNUM <3)b
GROUP BY decode(b.rno,1,indate_vc,2,'�Ѱ�')
ORDER BY �Ǹų�¥;


 ����) CASE...WHEN  ������ Ȱ���� ��
 member1 ���̺��� �̿��Ͽ� ���̵� �������� ������ -1 �� ��ȯ�ϰ�
 ���̵� �����ϸ� ������� ���Ͽ� ������ 1�� ��ȯ�ϰ�
 �ٸ��� 0�� ��ȯ�ϴ� selelct���� �ۼ��Ͻÿ�.
 
SELECT m_name
 FROM member1
 WHERE m_id =: ID
      AND m_pw =: pw;
      
edit member1;
 
SELECT CASE WHEN m_id =:ID THEN 0 ELSE -1 END
FROM member1;

SELECT CASE WHEN m_id =:ID THEN 0 END FROM member1
WHERE ROWNUM =1;

SELECT CASE WHEN m_id =:ID THEN 0
              ELSE -1
              END
   FROM member1
WHERE ROWNUM =1;

-- -1�̸� ���̵� �������� �ʴ´�
-- 1�̸� ���̵�� ����� ��� ��ġ�Ѵ�
-- 0�� ���� ���̵�� ���������� ����� Ʋ����
SELECT result
    FROM (SELECT CASE WHEN m_id =:ID THEN
                                 CASE WHEN m_pw =:pw THEN 1                
                                 ELSE 0
                                 END
                                 ELSE -1
                                 END AS result
                    FROM member1
                 ORDER BY result desc
                  )
WHERE ROWNUM = 1;

SELECT m_id, ROWNUM
    FROM member1;


--�����ȣ�� ä���ϴµ� �ִ밪���� 1�� ���� ���� ���ο� ����� ������� ä���ϴ� ��츦 �����غ���.....
SELECT /*+index_desc(emp pd_emp)*/ empno
    FROM emp;
    
SELECT /*+index_desc(emp pd_emp)*/ empno+1
    FROM emp;
    
SELECT /*+index_desc(emp pd_emp)*/ empno+1
    FROM emp
WHERE ROWNUM = 1;

--------------------------------------------------------------����(231121 ����)-----------------
 --1)))))))))))))))))))))))))))))))))))))))))))�÷������� �ִ� �������ڸ� ���� �ο� ������ ������ ����Ͻÿ�.
 
 SELECT * FROM test11;
 
--1) 
 decode(rno, 1, '1�г�', 2, '2�г�', 3, '3�г�', 4, '4�г�')
 
SELECT dept 
    FROM test11,
                (
                    SELECT ROWNUM RNO FROM DEPT WHERE ROWNUM <= 4
                );
                
SELECT dept , decode(rno, 1, '1�г�', 2, '2�г�', 3, '3�г�', 4, '4�г�')
    FROM test11,
                (
                    SELECT ROWNUM RNO FROM DEPT WHERE ROWNUM <= 4
                );
                
--2)                
DECODE(RNO, 1, FRE, 2, SUP, 3, JUN, 4, SEN)

--���� ��
SELECT dept , decode(rno, 1, '1�г�', 2, '2�г�', 3, '3�г�', 4, '4�г�'),
                DECODE(RNO, 1, FRE, 2, SUP, 3, JUN, 4, SEN)
    FROM test11,
                (
                    SELECT ROWNUM RNO FROM DEPT WHERE ROWNUM <= 4
                )
ORDER BY DEPT ASC, decode(rno, 1, '1�г�', 2, '2�г�', 3, '3�г�', 4, '4�г�');

-------------
--2)))))))))))))))))))))))))))))))))))))))))))))))
1�ܰ� - ���ξ��� EMP ���ո����� �� �� �ִ¸�ŭ�� �غ���

SELECT * FROM EMP WHERE ENAME = 'SMITH';

SELECT 1, 2, 3 FROM DUAL
UNION ALL
SELECT 2 FROM dual;

SELECT DECODE(JOB, 'CLERK', SAL)
    FROM EMP;

SELECT DECODE(JOB, 'CLERK', SAL)
                ,decode(JOB, 'salesman', sal)
                ,decode(JOB, 'clerk', NULL, 'salesman', NULL, sal)
    FROM EMP;
    
SELECT sum(sal)
    FROM emp
 GROUP BY deptno;
    
SELECT sum(DECODE(JOB, 'CLERK', SAL))
                ,sum(decode(JOB, 'salesman', sal))
                ,sum(decode(JOB, 'clerk', NULL, 'salesman', NULL, sal))
    FROM EMP;
    
SELECT deptno
                ,sum(DECODE(JOB, 'CLERK', SAL))
                ,sum(decode(JOB, 'salesman', sal))
                ,sum(decode(JOB, 'clerk', NULL, 'salesman', NULL, sal))
    FROM EMP
GROUP BY deptno;

SELECT dname
                ,sum(DECODE(JOB, 'CLERK', SAL))
                ,sum(decode(JOB, 'salesman', sal))
                ,sum(decode(JOB, 'clerk', NULL, 'salesman', NULL, sal))
                ,sum(sal)
    FROM EMP, dept
 WHERE emp.deptno = dept.deptno
GROUP BY dept.dname;

SELECT '�Ѱ�' FROM dual;

SELECT '�Ѱ�'
                ,sum(DECODE(JOB, 'CLERK', SAL))
                ,sum(decode(JOB, 'salesman', sal))
                ,sum(decode(JOB, 'clerk', NULL, 'salesman', NULL, sal))
                , sum(sal)
    FROM dept;

SELECT sum(DECODE(JOB, 'CLERK', SAL))
                ,sum(decode(JOB, 'salesman', sal))
                ,sum(decode(JOB, 'clerk', NULL, 'salesman', NULL, sal))
    FROM EMP;
    
SELECT dname
                ,sum(DECODE(JOB, 'CLERK', SAL))
                ,sum(decode(JOB, 'salesman', sal))
                ,sum(decode(JOB, 'clerk', NULL, 'salesman', NULL, sal))
                ,sum(sal)
    FROM EMP, dept
 WHERE emp.deptno = dept.deptno
GROUP BY dept.dname
UNION ALL
SELECT '�Ѱ�'
                ,sum(DECODE(JOB, 'CLERK', SAL))
                ,sum(decode(JOB, 'SALESMAN', sal))
                ,sum(decode(JOB, 'clerk', NULL, 'SALESMAN', NULL, sal))
                , sum(sal)
    FROM emp;
    
--�������� : ���̺��� �� ���� �а� ó���ϴ� ����� ����?
-- 1) ������ ���� �������� �μ����̴ϱ� group by ���� �غ���?
SELECT deptno, clerk_sum, salesman_sum, etc_sum
    FROM(
                    SELECT deptno
                                    ,sum(DECODE(JOB, 'CLERK', SAL)) clerk_sum
                                    ,sum(decode(JOB, 'SALESMAN', sal)) salesman_sum
                                    ,sum(decode(JOB, 'CLERK', NULL, 'SALESMAN', NULL, sal)) etc_sum
                                    , sum(sal)
                        FROM emp
                    GROUP BY deptno
                );
     
SELECT *
    FROM (           
                SELECT deptno, clerk_sum, salesman_sum, etc_sum
                    FROM (      
                                    SELECT deptno
                                                    ,sum(DECODE(JOB, 'CLERK', SAL)) clerk_sum
                                                    ,sum(decode(JOB, 'SALESMAN', sal)) salesman_sum
                                                    ,sum(decode(JOB, 'CLERK', NULL, 'SALESMAN', NULL, sal)) etc_sum
                                                    , sum(sal)
                                        FROM emp
                                    GROUP BY deptno
                               )
                  )E, dept d;
                  
--������������ ����� �÷��� ���������� ���Ұ�������
-- �ζ��κ信�� ����� �÷��� ���̺� ��ġ�̹Ƿ� ����� �����ϴ�       
SELECT d.dname, E.clerk_sum, E.salesman_sum, E.etc_sum
    FROM (           
                SELECT deptno, clerk_sum, salesman_sum, etc_sum
                    FROM (      
                                    SELECT deptno
                                                    ,sum(DECODE(JOB, 'CLERK', SAL)) clerk_sum
                                                    ,sum(decode(JOB, 'SALESMAN', sal)) salesman_sum
                                                    ,sum(decode(JOB, 'CLERK', NULL, 'SALESMAN', NULL, sal)) etc_sum
                                                    , sum(sal)
                                        FROM emp
                                    GROUP BY deptno
                               )
                  )E, dept d
 WHERE E.DEPTNO = d.deptno;
 
SELECT
                *
    FROM (
                    SELECT d.dname, E.clerk_sum, E.salesman_sum, E.etc_sum
                        FROM (           
                                    SELECT deptno, clerk_sum, salesman_sum, etc_sum
                                        FROM (      
                                                        SELECT deptno
                                                                        ,sum(DECODE(JOB, 'CLERK', SAL)) clerk_sum
                                                                        ,sum(decode(JOB, 'SALESMAN', sal)) salesman_sum
                                                                        ,sum(decode(JOB, 'CLERK', NULL, 'SALESMAN', NULL, sal)) etc_sum
                                                                        , sum(sal)
                                                            FROM emp
                                                        GROUP BY deptno
                                                   )
                                      )E, dept d
                     WHERE E.DEPTNO = d.deptno
                )A,
                ( SELECT ROWNUM rno FROM dept WHERE ROWNUM < 3)b;

--b.rno�� 1�� ������ dname, 2�̸� '�Ѱ�'
SELECT
                decode(b.rno, 1, dname, 2, '�Ѱ�')
    FROM (
                    SELECT d.dname, E.clerk_sum, E.salesman_sum, E.etc_sum
                        FROM (           
                                    SELECT deptno, clerk_sum, salesman_sum, etc_sum
                                        FROM (      
                                                        SELECT deptno
                                                                        ,sum(DECODE(JOB, 'CLERK', SAL)) clerk_sum
                                                                        ,sum(decode(JOB, 'SALESMAN', sal)) salesman_sum
                                                                        ,sum(decode(JOB, 'CLERK', NULL, 'SALESMAN', NULL, sal)) etc_sum
                                                                        , sum(sal)
                                                            FROM emp
                                                        GROUP BY deptno
                                                   )
                                      )E, dept d
                     WHERE E.DEPTNO = d.deptno
                )A,
                ( SELECT ROWNUM rno FROM dept WHERE ROWNUM < 3)b
GROUP BY  decode(b.rno, 1, dname, 2, '�Ѱ�')
ORDER BY decode(b.rno, 1, dname, 2, '�Ѱ�');

--���� ���
--sum�� �ؾ߸� �Ѵ�!
SELECT
                decode(b.rno, 1, dname, 2, '�Ѱ�')
                ,sum(A.clerk_sum)
                , sum(A.salesman_sum)
                , sum(A.etc_sum)
                , sum(A.sal_sum) AS dept_sal
    FROM (
                    SELECT d.dname, E.clerk_sum, E.salesman_sum, E.etc_sum, E.sal_sum
                        FROM (           
                                    SELECT deptno, clerk_sum, salesman_sum, etc_sum, sal_sum
                                        FROM (      
                                                        SELECT deptno
                                                                        ,sum(DECODE(JOB, 'CLERK', SAL)) clerk_sum
                                                                        ,sum(decode(JOB, 'SALESMAN', sal)) salesman_sum
                                                                        ,sum(decode(JOB, 'CLERK', NULL, 'SALESMAN', NULL, sal)) etc_sum
                                                                        , sum(sal) sal_sum
                                                            FROM emp
                                                        GROUP BY deptno
                                                   )
                                      )E, dept d
                     WHERE E.DEPTNO = d.deptno
                )A,
                ( SELECT ROWNUM rno FROM dept WHERE ROWNUM < 3)b
GROUP BY  decode(b.rno, 1, dname, 2, '�Ѱ�')
ORDER BY decode(b.rno, 1, dname, 2, '�Ѱ�');
                  