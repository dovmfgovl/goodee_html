--------------------JOIN--------------------------------------------
--------------------OUTER JOIN-------------------------------
�� ����� ����, salary, �������ѱݾ�, �������ѱݾ��� ������ �Ѵ�.
temp�� emp_level�� �����Ͽ� ����� �����ֵ�, ������ �������� ��ϵǾ� ���� ����
'����' ����� ����, �̸�, salary �������̶� ���� �� �ֵ��� ������ �ۼ��Ͻÿ�.

SELECT emp_name, salary, from_sal, to_sal
    FROM temp LEFT JOIN emp_level
      ON  temp.lev = emp_level.lev;

--�Ʒ� 2�� ����      
SELECT empno, ename, dname
    FROM emp, dept
 WHERE emp.deptno(+) = dept.deptno;
 
SELECT empno, ename, dname
    FROM emp RIGHT OUTER JOIN dept
        ON emp.deptno = dept.deptno;
        
SELECT empno, ename, dname
    FROM emp FULL OUTER JOIN dept
        ON emp.deptno = dept.deptno;
        
------------Non-equal JOIN------------------------------------------
ȸ�����հ� ��ǰ������ �������´�? : n:n

SELECT * FROM t_giftmem;

SELECT * FROM t_giftpoint;

--īŸ�þ� �� �߻�
SELECT *
    FROM t_giftmem, t_giftpoint;
    
SELECT *
    FROM t_giftmem mem, t_giftpoint poi
 WHERE poi.name_vc = '��������';
 
--non-equals join�̴� (<=, >=�� ���ϴ�)
SELECT *
    FROM t_giftmem mem, t_giftpoint poi
 WHERE poi.name_vc = '��������'
      AND poi.point_nu <= mem.point_nu; 
      
--------------Self Join-------------------------------------
SELECT * FROM emp;

SELECT A.ename AS "�Ŵ���", b.ename
    FROM emp A, emp b
  WHERE A.empno = b.mgr;

---------------Cross Join--------------------  
SELECT *
    FROM emp CROSS JOIN dept; 

-------��������-----------------------------------------------------    
temp�� tdept�� �̿��Ͽ� ���� �÷��� �����ִ� SQL�� ����� ����.
�����μ��� 'CA0001'�� �μ��� �Ҽӵ� ������ 1.���, 2.����, 3.�μ��ڵ�
4.�μ���, 5.�����μ��ڵ�, 6.�����μ���, 7.�����μ�����̵�, 8.�����μ��强��
������ �����ָ� �ȴ�.

--�� Ǯ��...... Ʋ��
SELECT P.emp_id, P.emp_name, P.dept_code, t1.dept_name, t2.dept_code, t2.dept_name, t2.DEPT_CODE, P.EMP_NAME
    FROM temp P, tdept T1, tdept t2
 WHERE T1.PARENT_DEPT = T2.DEPT_CODE
      AND P.dept_code = t1.dept_code
      AND T2.BOSS_ID =  P.emp_id
      AND t2.dept_code = 'CA0001';
      
-- ������ Ǯ��
SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
    FROM temp NATURAL JOIN tdept;

SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
    FROM temp A, tdept b
 WHERE A.dept_code = b.dept_code;
 
-- ����  ������ ����: ���̺� �������� n-1
SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
                , c.dept_code AS "�����μ��ڵ�"
                , c.dept_name AS "�����μ���"
    FROM temp A, tdept b, tdept c
 WHERE A.dept_code = b.dept_code
      AND b.parent_dept = c.dept_code
      AND c.dept_code = 'CA0001';
      
SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
                , c.dept_code AS "�����μ��ڵ�"
                , c.dept_name AS "�����μ���"
                , C.BOSS_ID AS "�����μ�����̵�"
                , d.emp_name AS "�����μ����̸�"
    FROM temp A, tdept b, tdept c, temp d
 WHERE A.dept_code = b.dept_code
      AND b.parent_dept = c.dept_code
      AND c.boss_id = d.emp_id
      AND c.dept_code = 'CA0001';