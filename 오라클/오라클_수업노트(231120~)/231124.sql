--DML
SELECT 
    FROM
 WHERE
 GROUP BY
 [[HAVING]]
 ORDER BY
 
SELECT �÷���1, �÷���2,.... �Լ���(�÷���3)
    FROM ����1, ����2, (SELECT �� - �ζ��κ�)
 WHERE �÷���1 = ��(����� �ƴϴ�. select�� - ��������) : ���ǰ˻�, �����ϴ� ��
     AND �÷���2 = ��(SELECT ��) : AND�� ������ - ���Ұ� �پ��. ����� �� ����. �Ϸ� ���� -> �ӵ� ����
       OR  �÷���3 = ��(IN)  : OR�� ������ - ����� ���� ��� ����. �Ϸ� ����(�����ϸ� ������� �� ��)
 GROUP BY �÷���1, �÷���2(��, �׷��Լ� �ƴ�. GROUP BY ���� ���� �÷��� ���� ��)
 [[HAVING]]
 ORDER BY
 
--����: ���� �׷��� �׷� �Լ��� �ƴմϴ�
SELECT ename, sum(sal)
    FROM emp;
 
--���ϴ� �� ��µ��� ����  
SELECT max(ename), sum(sal)
    FROM emp
 GROUP BY ename;
 
--GROUP BY���� ���� ���� ������ �� �� �ִ� : ������ ���� ���⵵ �������� ���� ����
SELECT deptno, JOB
    FROM emp
GROUP BY deptno, JOB
ORDER BY deptno;

--sum(decode(...)) ���� : �Ұ�, �Ѱ�, ��...
SELECT decode(JOB, 'CLERK', sal, NULL)
    FROM emp;
    
SELECT sum(decode(JOB, 'CLERK', sal, NULL))
    FROM emp;
    
SELECT count(empno), count(comm) FROM emp;

---------���� Ǯ��.....-------------------------���� ����....?-------------
SELECT ROWNUM rno FROM temp;

SELECT ROWNUM rno, emp_name FROM temp;

--1, 2, 3�� ��� 1�� ��µǵ��� �Ѵ� : �ֳ��ϸ� 3�� �̸��� ��� ù �ٿ� ����ؾ� �ϴϱ�
SELECT rno, ceil(rno/3) cno, mod(rno, 3) mno
                , emp_name
    FROM (
                    SELECT ROWNUM rno, emp_name FROM temp
                );
                
SELECT ceil(rno/3) cno
    FROM (
                    SELECT ROWNUM rno FROM temp
                )
 GROUP BY ceil(rno/3)
 ORDER BY cno;
 
SELECT '��浿', 'ȫ�浿', '�ڹ���' FROM dual
UNION ALL
SELECT ' ������', '�̼���', '������' FROM dual;

decode(mod(rno, 3),1, '��浿')

SELECT ceil(rno/3) cno
                , max(decode(mod(rno, 3),1, mod(rno, 3))
                , max(decode(mod(rno, 3),2, mod(rno, 3)) 
                , max(decode(mod(rno, 3),0, mod(rno, 3)) 
    FROM (
                    SELECT ROWNUM rno, emp_name FROM temp
                );

SELECT ceil(rno/3) cno
                , decode(mod(rno, 3),1, emp_name) d1
                , decode(mod(rno, 3),2, emp_name) d2
                , decode(mod(rno, 3),0, emp_name) d3
    FROM (
                    SELECT ROWNUM rno, emp_name FROM temp
                )
 GROUP BY ceil(rno/3)
 ORDER BY cno;
 
SELECT ceil(rno/3) cno
                , max(decode(mod(rno, 3),1, emp_id))||'-'||max(decode(mod(rno, 3),1, emp_name))
                ,max(decode(mod(rno, 3),2, emp_id))||'-'||max(decode(mod(rno, 3),2, emp_name))
                , max(decode(mod(rno, 3),0, emp_id))||'-'||max(decode(mod(rno, 3),0, emp_name))
    FROM (
                    SELECT ROWNUM rno, emp_id, emp_name FROM temp
                )
 GROUP BY ceil(rno/3)
 ORDER BY cno;
 
 
SELECT ceil(rno/5) cno
                , max(decode(mod(rno, 5),1, emp_id))||'-'||max(decode(mod(rno, 5),1, emp_name))
                ,max(decode(mod(rno, 5),2, emp_id))||'-'||max(decode(mod(rno, 5),2, emp_name))
                ,max(decode(mod(rno, 5),3, emp_id))||'-'||max(decode(mod(rno, 5),3, emp_name))
                ,max(decode(mod(rno, 5),4, emp_id))||'-'||max(decode(mod(rno, 5),4, emp_name))
                , max(decode(mod(rno, 5),0, emp_id))||'-'||max(decode(mod(rno, 5),0, emp_name))
    FROM (
                    SELECT ROWNUM rno, emp_id, emp_name FROM temp
                )
 GROUP BY ceil(rno/5)
 ORDER BY cno;
 
 ----------------------------------------------------------------------------------------------
 ---------------------------------JOIN---------------------------------------------------
 ----1.-------NATURAL JOIN-----------------------------------------
 --------NATURAL JOIN  ��õ��---------
SELECT empno, ename, dname
    FROM emp;
    
SELECT empno, ename, dname
    FROM emp, dept; -- īŸ�þ� ��
    
SELECT empno, ename, dname
    FROM emp NATURAL JOIN dept;
    
SELECT empno, ename, dname
    FROM emp A JOIN dept b
        ON A.deptno = b.deptno;
    
SELECT empno, ename, dname
    FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 -----------------------------------       
---����----------------
tcom�� work_year = '2001'�� �ڷ�� temp�� ������� �����ؼ� join�� ��
comm�� �޴� ������ ����, salary + COMM�� ��ȸ�� ���ÿ�.

SELECT A.emp_id, A.emp_name, 100+10
    FROM temp A;
    
SELECT A.emp_id, A.emp_name, A.salary+b.comm
    FROM temp A, tcom b
 WHERE A.emp_id = b.emp_id
      AND b.work_year = '2001';

SELECT dept.deptno, emp.ename
    FROM emp, dept
  WHERE emp.deptno = dept.deptno;
      
---���� ������ ���߷� �������� �ٲٱ�
SELECT emp_id, emp_name, salary+comm
    FROM temp NATURAL JOIN tcom
 WHERE work_year = '2001';
 
------���� -------
temp�� emp_level�� �̿��� emp_level�� ���� ������ ���� ����/���� ���� ���� ��� ������ �����, ����, ����, salary�� �о��.

-- �� Ǯ��
SELECT T.emp_id, T.emp_name, E.lev, T.salary 
    FROM temp T, emp_level E
 WHERE E.lev = T.lev
       AND T.salary BETWEEN 37000000 AND 75000000;
       
--������ Ǯ��
SELECT A.emp_id, A.emp_name
    FROM temp A, emp_level b;
    
SELECT A.emp_id, A.emp_name, b.lev
    FROM temp A, emp_level b
 WHERE b.lev = '����';
 
SELECT count(emp_id) FROM temp WHERE lev='����';

----���� ��--
SELECT A.emp_id, A.emp_name, A.lev
    FROM temp A, emp_level b
 WHERE b.lev = '����'
     AND A.salary BETWEEN from_sal AND to_sal; 

--��������� ����  (��Ǯ��)
SELECT A.emp_id, A.emp_name, A.lev
    FROM temp A, emp_level b
 WHERE b.lev = '����'
     AND A.salary BETWEEN from_sal AND to_sal
     AND A.emp_type NOT IN('����');
     
-------------------2. OUTER JOIN--------------------------------------
INTERSECT
SELECT deptno FROM dept;

--NULL
SELECT deptno FROM emp
MINUS
SELECT deptno FROM dept;

--40
SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;

--10, 20, 30
SELECT DISTINCT(deptno) FROM emp;

SELECT empno, dept.deptno, dname
    FROM emp, dept
 WHERE emp.deptno(+) = dept.deptno;
 
-------������� ����, ���� ������ �׷��� �����޶�
SELECT b.emp_id, b.emp_name, b.lev, A.from_sal, A.to_sal
    FROM emp_level A, temp b
 WHERE A.lev(+) = b.lev;
 
-------------3. self join---------------------------------------------
����) tdept���̺� �ڽ��� ���� �μ� ������ �����ϰ� �ִ�.
�� ���̺��� �̿��Ͽ� �μ��ڵ�, �μ���, �����μ��ڵ�, �����μ����� �о���� 
������ ����� ����.

--�����ϴ� ����~~~~~~~
--���̺� �ϳ��δ� ���ϴ� ���� ����� �� ����
SELECT dept_name, parent_dept
    FROM tdept;
    
SELECT dept_name AS "�μ���"
              , dept_name AS "�����μ���"
    FROM tdept;
    
SELECT A.dept_name AS "�μ���"
      , a.dept_code
     , b.dept_name AS "�����μ���"
     , b.dept_code
    FROM tdept A, tdept b
 order by a.dept_name, b.dept_name;

--���� �������°� 1:n�̴� ���Ǹ� ���ؼ� ����ؾ� �Ѵ�
SELECT A.dept_name AS "�μ���"
      , b.dept_name AS "�����μ���"
    FROM tdept A, tdept b
 WHERE A.parent_dept = b.dept_code;
 
 --~~~~~~~~~~
����) tdept���̺� �ڽ��� ���� �μ� ������ �����ϰ� �ִ�.
�� ���̺��� �̿��Ͽ� �μ��ڵ�, �μ���, �����μ��ڵ�, �����μ����� �о���� 
������ ����� ����.

--�� Ǯ��
SELECT A.dept_code AS "�μ��ڵ�"
            , A.dept_name AS "�μ���"
            , b.parent_dept AS "�����μ��ڵ�"
            , b.dept_name AS "�����μ���"
    FROM tdept A, tdept b
 WHERE A.parent_dept = b.dept_code;
 

--------------------------------------------------------------------------------
-----���� -----outer join �غ���---����Ŭ\����Ŭ�ǽ��ҽ�\SQL\04��------
�̵� �������� �۾��ð��� ª�� �ɸ��� �ð� ������� 1���� 15������ ������ 
�Űܼ� ����Ͻÿ�.

SELECT * FROM t_worktime;

--��ũ �Լ��� ���� Ǯ��
SELECT workcd_vc, time_nu
                , rank() OVER(ORDER BY time_nu) rnk
    FROM t_worktime;
          
SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
    WHERE ROWNUM < 4;
    
SELECT *
    FROM (
                    SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
                        WHERE ROWNUM < 4
                )A,
                (
                    SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
                        WHERE ROWNUM < 4
                )b;
                
SELECT *
    FROM (
                    SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
                        WHERE ROWNUM < 4
                )A,
                (
                    SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
                        WHERE ROWNUM < 4
                )b
  WHERE A.time_nu >= b.time_nu
  ORDER BY A.time_nu;
 
SELECT A.workcd_vc, A.time_nu, count(b.workcd_vc)
    FROM (
                    SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
                        WHERE ROWNUM < 4
                )A,
                (
                    SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
                        WHERE ROWNUM < 4
                )b
  WHERE A.time_nu >= b.time_nu
  GROUP BY A.workcd_vc, A.time_nu
  ORDER BY count(b.workcd_vc);
