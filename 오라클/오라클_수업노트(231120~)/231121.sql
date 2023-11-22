SELECT
             empno, ename
  FROM emp
 WHERE deptno = 10;

SELECT
             empno, sal
  FROM (SELECT
                             empno, ename
                  FROM emp
                 WHERE deptno = 10
            ) ;    

--�ӵ������ ���� - index, �ζ��κ� ������ �� ����(��� ���� �پ��)
--pk�� �ε��� ����
--���̺� ������ ���̵� �˻� ����
--fk�� �ش���� - �ߺ����

SELECT empno
    FROM emp;
    
 INSERT INTO ����() VALUES(select��)
 
 SELECT ename, sal FROM emp;
 
 --������� �ȿ� �μ��� �־��� : ������ȭ �������� ����
 
 --����� 50����, �μ����� 100����
 
 --�����ȹ : ctrl + E
 --���̺��� �� �� �̻��� �� ���� �о���̴� ���̺��� ������ ���� �ӵ� ���� �߻���
 
 SELECT 
                emp.empno, emp.ename, dept.dname
    FROM emp, dept
  WHERE dept.deptno = emp.deptno;
  
  
  -------�׷� �ռ�---------------------------------------------------------------------
  
  --max : ��ü ���� ó��
  SELECT
                max(sal)
    FROM emp;
    
-- �׷��Լ��� �Ϲ� Į�� ���� �θ��� �� �ҹ�
  SELECT
                max(sal), ename
    FROM emp;

-- �� ���� �ذ���    
--�÷� �ڸ��� �Լ��� ������ �� �ִµ� �� �� ��ȿ�� ������ ��� ���ؼ��� ���������� �ʿ��ϴ�(max���� �޴� ����� �̸��� �˰� �;��ٸ�)
  SELECT
                max(sal), max(ename), min(ename)
   FROM emp;
   
   --�������� Ȱ��
 SELECT ename
        FROM emp
    WHERE sal = (SELECT max(sal) FROM emp);
    
-- �μ��� �޿� ����� ���Ͻÿ�
--  : �׷��Լ��� ��ü���� ó���� �Ѵ�. ��� �� �������ؼ� �ӵ� ����. ���� �κй��� ó�� �ʿ�.
SELECT sal
    FROM emp;
 
--�׷��Լ��� �Ϲ��÷��� ���� ����� �� ���� 
 SELECT sal, avg(sal)
    FROM emp;
    
 SELECT avg(sal)
    FROM emp;
 
--distinct : �ߺ�����   
SELECT DISTINCT(deptno) FROM emp;

SELECT sal
    FROM emp
 GROUP BY dname;
 
SELECT deptno
    FROM emp
 GROUP BY deptno;
 
--having : group by ������
SELECT deptno, avg(sal)
    FROM emp
 GROUP BY deptno
 HAVING avg(sal) > 2000;

---------------------------------------------------------------

--1)����縸 ������ �ϱ�
SELECT * FROM t_letitbe;

SELECT mod(seq_vc,2) FROM t_letitbe;

SELECT mod(seq_vc,2) FROM t_letitbe
WHERE mod(seq_vc,2) = 1;

SELECT mod(seq_vc,2) FROM t_letitbe
WHERE mod(seq_vc,2) = 0;

DELETE FROM t_letitbe;

COMMIT;

SELECT mod(seq_vc,2), words_vc FROM t_letitbe
WHERE mod(seq_vc,2) = 1;

--������ Ǯ��
--���̺� �ִ� �÷��� select ���� ��� ���� ->
SELECT dname FROM emp;

--���� t_letitbe�� ���� �÷�(eng_words)�� select���� ����� �� ����
----��Ī�� ���� ���������� ���� �ʹٸ� �ζ��κ� ����ϱ� ->
SELECT decode(mod(seq_vc, 2),1, words_vc) eng_words
    FROM t_letitbe
WHERE eng_words = 1;

--�ζ��κ� ���
SELECT num, eng_words
    FROM (
                    SELECT mod(seq_vc, 2) num
                                     , decode(mod(seq_vc, 2),1, words_vc) eng_words
                         FROM t_letitbe
                 )
 WHERE num = 1;
 
--�ζ��κ� ������� ���� ��
 SELECT decode(mod(seq_vc, 2),1, words_vc) eng_words
    FROM t_letitbe
 WHERE mod(seq_vc, 2) = 1;

--2)�ѱ۰��縸 ������ �ϱ�
SELECT mod(seq_vc, 2), words_vc FROM t_letitbe
WHERE mod(seq_vc,2) = 0;

-- ������ ��
 SELECT decode(mod(seq_vc, 2),0, words_vc) han_words
    FROM t_letitbe
 WHERE mod(seq_vc, 2) = 0;

--3)��������� �ѱ� ���� ��� ������ �ϱ�(UNION ����ؼ�)
--3�� ������ ��� SELECT * FROM t_letitbe�� ���� �ƴմϴ�.
--����:�������� �̿��ϼž� �մϴ�.
--      ���� ���ּž� �մϴ�.
--     ��������� �ѱ۰��� ����� ��µǾ�� �մϴ�.
--�ش� ���̺��� ÷���� �帰 ����Ŭ �ҽ� ������ SQL����
--4�忡 �ִ� t_letitbe�� �����ϼ���
SELECT 1, 2, 3 FROM dual;

SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual
UNION ALL
SELECT 2 FROM dual;

SELECT mod(seq_vc, 2), words_vc FROM t_letitbe
WHERE mod(seq_vc, 2) = 1
UNION ALL
SELECT mod(seq_vc, 2), words_vc FROM t_letitbe
WHERE mod(seq_vc, 2) = 0;

--������ Ǯ��
SELECT seq_vc
                , decode(mod(seq_vc, 2), 1, words_vc) A
    FROM t_letitbe;
    
SELECT seq_vc
                , deceode(mod(seq_vc, 2), 0, words_vc) A
     FROM t_letitbe;
     
SELECT seq_vc, max(A) all_word
    FROM (
                    SELECT seq_vc
                                     , decode(mod(seq_vc, 2), 1, words_vc) A
                         FROM t_letitbe
                     UNION ALL
                     SELECT seq_vc
                                    , decode(mod(seq_vc, 2), 0, words_vc) A
                         FROM t_letitbe        
                )
 GROUP BY seq_vc
 ORDER BY to_number(seq_vc) ASC;
 
 --�� Ǯ�̿��� max ���� ����: �׷��Լ��� �Ϲ��Լ��� ���� ����� �� ����.
-- group by�� seq_vc�� �� �׷��� ������ ������ �� �÷� �ܿ��� select ���� �� �� ����. �� ������ ����ϱ� ���� max, min�� �� �ִ� ��.
-- max �ְų� min �ְų� ����� ������ ���� �� A�÷��� �������� ������ �ذ��ϴ� �뵵�� ���� �� ���̱� �����̴�.
 SELECT empno, sum(sal)
    FROM emp;

-- -> ��, group by �� ���� �ߺ� ����(distinct) �Ǳ� ������ �׷��Լ��� ���� ��� ����    
 SELECT deptno, sum(sal)
    FROM emp
 GROUP BY deptno;
 
SELECT deptno, sum(sal), max(sal)
    FROM emp
GROUP BY deptno;

--����(GROUP BY ǥ������ �ƴմϴ�.) : ������ sal�� ���Ϸ��� ���� �� �� �����Ƿ�
SELECT deptno, sal
    FROM emp
GROUP BY deptno;

--����  �ذ�. ��, group by�� ȿ���� ��������.
SELECT deptno, sal
    FROM emp
GROUP BY deptno,sal;

-- -> �׷��Ƿ� �׷� ���� �� �ϸ� ��
SELECT deptno, sal
    FROM emp;
    
-------231122 ���� �߰�------------------------------------------------------------------------------------------
--<��������>
-- 1. t_letitbe�� �� �� �о ó���Ѵ� 
-- 2. �� ��Ī�� A�� ���Ͻ��׳�?
SELECT seq_vc
                , decode(mod(seq_vc, 2), 1, words_vc) A
    FROM t_letitbe
UNION ALL   
SELECT seq_vc
                , decode(mod(seq_vc, 2), 0, words_vc) A
     FROM t_letitbe;
     
--����: ORA-01790: �����ϴ� �İ� ���� ������ �����̾�� �մϴ�
SELECT deptno FROM dept
UNION ALL
SELECT dname FROM dept;

--�ذ�: Ÿ���� ������ ���� - ���� �� letitbe�� Ÿ���� �����Ƿ� union all  ����
SELECT loc FROM dept
UNION ALL
SELECT dname FROM dept;

SELECT count(comm), count(empno) FROM emp;

SELECT decode(JOB, 'clerk', sal, NULL) FROM emp;

SELECT sum(decode(JOB, 'clerk', sal, NULL)) FROM emp;

SELECT decode(JOB, 'clerk', sal, NULL)
              , decode(JOB, 'salesman', sal, NULL)
              , decode(JOB, 'clerk', NULL, 'salesman', NULL, sal)
    FROM emp;
---------------------------------------------------------------------------------------231122------------
    
--------------------------------------------------------------------------
--t_giftpoint
--��ȭ Ƽ���� ���� �� �ִ� ����� ��ܰ� ���� ������ �ִ� ����Ʈ, ��ȭ Ƽ���� ����Ʈ
--�׸��� �� Ƽ���� ����� �� ���� ���� ����Ʈ�� ����Ͻÿ�.

SELECT * FROM t_giftpoint;

SELECT * FROM t_giftmem;

-- <�־��� ����> 
-- ��ȭƼ�� : 15000��
-- ���� ����Ʈ  : ȸ������ ����Ʈ -��ȭƼ�� ����Ʈ = �ܿ�����Ʈ

--<���ǽ�>
--��������Ʈ >= ��ȭƼ������Ʈ
--WHERE mem.poin_nu >= poi.point_nu

SELECT point_nu
    FROM t_giftpoint
 WHERE name_vc = '��ȭƼ��';

--īŸ�þ��� �� : �����͸� �����Ѵ�
SELECT *
    FROM t_giftpoint, t_giftmem;
    
SELECT mem.point_nu - poi.point_nu AS "�ܿ�����Ʈ"
    FROM t_giftmem mem, 
                (
                    SELECT point_nu
                        FROM t_giftpoint
                     WHERE name_vc = '��ȭƼ��'
                ) poi
WHERE mem.point_nu >= poi.point_nu;

SELECT mem.name_vc AS "�̸�"
                , mem.point_nu AS "��������Ʈ"
                , poi.point_nu AS "��������Ʈ"
                , mem.point_nu - poi.point_nu AS "�ܿ�����Ʈ"
    FROM t_giftmem mem, 
                (
                    SELECT point_nu
                        FROM t_giftpoint
                     WHERE name_vc = '��ȭƼ��'
                ) poi
WHERE mem.point_nu >= poi.point_nu;

--�ζ��κ並 ������� ���� �����
--  Nested loop ���ι������ ���Ѵ� : 30���� ����� ���� ��� üũ�ϴ� ��
SELECT mem.name_vc AS "�̸�"
                , mem.point_nu AS "��������Ʈ"
                , poi.point_nu AS "��������Ʈ"
                , mem.point_nu - poi.point_nu AS "�ܿ�����Ʈ"
    FROM t_giftmem mem, t_giftpoint poi
WHERE mem.point_nu >= poi.point_nu
    AND poi.name_vc = '��ȭƼ��';

--����2
--�����ž��� �����ϰ� �ִ� ���ϸ��� ����Ʈ�� ���� �� �ִ� ��ǰ �� ���� ����Ʈ�� ���� ���� �����ΰ�?
SELECT point_nu FROM t_giftmem
WHERE name_vc = '������';

--max(name_vc)���� �Ѱ���Ʈ�� ���� ���� ������ �����ؼ� ���� ����
SELECT max(point_nu)
    FROM t_giftpoint
 WHERE point_nu <= 50012;
 
SELECT name_vc
    FROM t_giftpoint
WHERE point_nu = 50000;

--50000�� �ڸ��� �������� �־� �� ����
SELECT name_vc
    FROM t_giftpoint
WHERE point_nu = (
                                        SELECT max(point_nu)
                                             FROM t_giftpoint
                                        WHERE point_nu <= 50012
                                    );

-------------------------------------------------------------------------------------------
-- DECODE�� �Ϲ����� ���α׷��� ����� if���� SQL���� �Ǵ� PL/SQL ������ ����鿩 ����ϱ� ���� ������� ����Ŭ �Լ�
-- ���� �͸� ���� �� �ִ�. ũ��, �۴ٴ� ���� �� ����.

--IF A = B THEN
--    RETURN 'T';
--END IF;
--
--DECODE(1, 1, 'T')

--if else: DECODE(1, 2, 'T', 'F')
SELECT DECODE(1, 1, 'T')
              , DECODE(1, 2, 'T', 'F')
    FROM dual;
    
-- ����1) �ִ� ���ǽð��� ������ ������ '�Ϲݰ���'�� ���� �ް��� �Ѵ�. �������� �ۼ��Ͻÿ�.
--�������� �������� �ʴ� ���: null�� ��ȯ�Ѵ�. ���� �Ʒ� �� �������� ��� ���� �����ϴ�.
SELECT decode(lec_time, lec_point, '�Ϲݰ���') FROM lecture;

SELECT decode(lec_time, lec_point, '�Ϲݰ���', NULL) FROM lecture;

-- ����2) �ִ簭�ǽð��� ������ ���� ������ ���ڸ� �˰� �ʹ�. �������� �ۼ��Ͻÿ�.

--decode�� ������� ���� ���
SELECT count(lec_id)
    FROM lecture
WHERE lec_time = lec_point;

--decode�� ����� ���
--���� �� ���
SELECT count(decode(lec_time, lec_point, lec_id))
    FROM lecture;
    
-- ������ ���
--�־����� ���� ������ null�� ����. decode(lec_time, lec_point, 1) ���⿡�� decode(lec_time, lec_point, 1, null)�� �����Ǿ� ����
SELECT count(decode(lec_time, lec_point, 1))
    FROM lecture;

SELECT decode(lec_time, lec_point, 1)
    FROM lecture;
    
--DECODE�� ���� ũ�� �۴� �غ���
-- a-b�� ���� �� -1�� �������� a�� �� ���� �� ��� ���� �� �� �ִ�.
SELECT decode(A-b, -1) FROM dual;

--***sign �Լ�**
SELECT sign(1+100), sign(-5000), sign(100-100), sign(5000-5000)
    FROM dual;
    
SELECT decode(sign(100-200), 1, '���', -1, '����', 0, '0') FROM dual;

--decode: FROM�� ����� ��𼭳� ����� �� �ִ�.

--null�� �ִ� ��쿡 ������ ��� �ǳ�?
--null�� �𸥴�, �������� �ʾҴ�. ���� ���� �� �� ����. �׷��� �� �ڿ� �ٿ���.
--null�� �÷��� ������������ �����ϸ� null�� �� �տ� �´�.
SELECT comm
    FROM emp
ORDER BY comm desc;

SELECT comm
    FROM emp
ORDER BY comm ASC;

--����3) ���ǽð��� ������ ������ '�Ϲݰ���'�� ���� ���� �� ���ĵ� �ϰ� �ʹٸ�?
--���ǽð�: lec_time
--����: lec_point
--"������" : decode(lec_time, lec_point, '�Ϲݰ���', null)

--���� ���� ���� �־����� �ٸ� ���� ������ null�̴�
SELECT decode(lec_time, lec_point, '�Ϲݰ���')
    FROM lecture;
    
SELECT decode(lec_time, lec_point, '�Ϲݰ���')
    FROM lecture
ORDER BY decode(lec_time, lec_point, '�Ϲݰ���') desc;  

SELECT decode(lec_time, lec_point, '�Ϲݰ���', NULL)
    FROM lecture
ORDER BY decode(lec_time, lec_point, '�Ϲݰ���') ASC;

--����4) �����Ͽ� �ش����ڿ� 01�� �ٿ��� 4�ڸ� ��ȣ�� �����, 
--ȭ���Ͽ� 11, �����Ͽ� 21, ����Ͽ�, 31, �ݿ��Ͽ� 41, ����Ͽ� 51,
--�Ͽ��Ͽ� 61�� �ٿ��� 4�ڸ� ��ȣ�� ����ٰ� �� �� 
--��ȣ�� SELECT�ϴ� SQL�� ����� ���ÿ�.(decode�� Ȱ���Ͽ�)

--����ȯ �Լ�
-- to_char
-- to_number
-- to_date
SELECT to_char(sysdate, 'YYYY-MM-DD') FROM dual;

--UI(User Interface or View ����) �޾ƿ��� ���� ��찡 ��κ��̴�(�޾ƿ� ���� ���ڿ��̴�)
--���� to_date�� �� ������� ����.
SELECT sysdate-1, sysdate+2 FROM dual;

<input TYPE="text" NAME="start_day">

SELECT to_date('2023-11-23')+1 FROM dual;

SELECT to_char(sysdate, 'day') FROM dual;

SELECT decode(to_char(sysdate, 'day'), 'ȭ����', '11', '������')
    FROM dual;
    
SELECT to_char(sysdate, 'dd') FROM dual;

SELECT to_char(sysdate, 'dd')||'11' FROM dual;

SELECT decode(to_char(sysdate, 'day'), '������', '01'
                                                                         , 'ȭ����', '11'
                                                                          , '������', '21'
                                                                          , '�����', '31'
                                                                          , '�ݿ���', '41'
                                                                          , '�����', '51'
                                                                          , '�Ͽ���', '61')
     FROM dual;

SELECT to_char(sysdate, 'dd')||
                decode(to_char(sysdate, 'day'), '������', '01'
                                                                          , 'ȭ����', '11'
                                                                          , '������', '21'
                                                                          , '�����', '31'
                                                                          , '�ݿ���', '41'
                                                                          , '�����', '51'
                                                                          , '�Ͽ���', '61') sec_key
       FROM dual;

-- ����5) ���ǽð��� ������ ���ų� ���ǽð��� �������� ������ '�Ϲݰ���'�� �����ް� ���ǽð��� �������� ū ��츸 '�������'�̶� �����ް� �ʹٸ� ��� ó���� �� ������?
--�� Ǯ��
SELECT lec_id, lec_time, lec_point, decode(sign(lec_time-lec_point),0, '�Ϲݰ���',-1, '�Ϲݰ���',1, '�������')
    FROM lecture;

-- ������ Ǯ�� 
SELECT decode(sign(lec_time-lec_point) , 1, '�������', '�Ϲݰ���') FROM lecture;

-- ����5-1) lec_time�� ũ�� '�������', lec_point�� ũ�� '��Ÿ����', ���� ������ '�Ϲݰ���'���� ���� ���� �ް��� �Ѵ�. �������� �ۼ��غ��ÿ�.
SELECT lec_id, lec_time, lec_point, decode(sign(lec_time-lec_point), 1, '�������', -1, '��Ÿ����', 0, '�Ϲݰ���')
    FROM lecture;

--��������
--���� : ������̺��� job�� clerk�� ����� �޿� ��,  salesman�� �����
--�޿��� ���� ���ϰ� ������ job�� ���ؼ��� ��Ÿ ������ ���Ͻÿ�(��, ��� ���̺��� �� ���� �а� ó���� ��).
--<��Ʈ>
SELECT decode(JOB, 'clerk', sal, NULL)
    FROM emp;
    
SELECT decode(JOB, 'clerk', sal, NULL)
                , decode(JOB, 'salesman', sal, NULL)
    FROM emp;
    
SELECT decode(JOB, 'clerk', sal, NULL)
                , decode(JOB, 'salesman', sal, NULL)
                , decode(JOB, 'clerk', NULL, 'salesman', NULL, sal)
    FROM emp;
    
--������ Ǯ��
SELECT decode(JOB, 'clerk', sal)
    FROM emp;
    
SELECT sum(decode(JOB, 'clerk', sal)), max(sal), count(empno)
    FROM emp;
    
SELECT count(empno) FROM emp;

SELECT decode(JOB, 'clerk', sal)
                , decode(JOB, 'salesman', sal, NULL)
    FROM emp;

--empno�� �ٸ� ����� �ƹ� ���� ����
--empno�� max �Լ��� ����� �� �������� ������ �ذ��ϱ� ���ؼ��� ��
SELECT max(empno),
                count(decode(JOB, 'clerk', sal, NULL))
                , sum(decode(JOB, 'clerk', sal, NULL))
                , count(decode(JOB, 'salesman', sal, NULL))
                , sum(decode(JOB, 'salesman', sal, NULL))
    FROM emp;

--*****************sum(decode ����) - ���� ����!!!************************--------
    
SELECT 
                sum(decode(JOB, 'clerk', sal, NULL))
                , sum(decode(JOB, 'salesman', sal, NULL))
                , sum(decode(JOB, 'clerk', NULL, 'salesman', NULL, sal)) etc_sal
                , sum(sal)
    FROM emp;
    
--�������� 2) 
--�ο쿡 �ִ� �̸��� �÷������� ���� ����� ���� �ִ�.
--emp ���̺��� ��� �̸��� �� �࿡ ���, ������ 3�� �����ִ� query���� �ۼ��Ͻÿ�.
SELECT ename
    FROM emp
WHERE ename = ntitle(3);
 
--�����н�����
--�� �࿡ 1�г���� 4�г���� �и� �� �࿡ �ϳ��� �г⸸ �������� (6��-06-002)
--����� �ο쿡 �г⺰ ���� -> �÷����� �г⺰ ������ �������� ��ȯ
--����: �÷������� �ִ� �а��� ���� ���� ����! �ο췹���� ������ ����Ͻÿ�.

SELECT * FROM test11;

SELECT 