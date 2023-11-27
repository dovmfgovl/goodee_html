--------------------JOIN--------------------------------------------
--------------------OUTER JOIN-------------------------------
각 사번의 성명, salary, 연봉하한금액, 연봉상한금액을 보고자 한다.
temp와 emp_level을 조인하여 결과를 보여주되, 연봉의 상하한이 등록되어 있지 않은
'수습' 사원은 성명, 이름, salary 까지만이라도 나올 수 있도록 쿼리를 작성하시오.

SELECT emp_name, salary, from_sal, to_sal
    FROM temp LEFT JOIN emp_level
      ON  temp.lev = emp_level.lev;

--아래 2개 동일      
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
회원집합과 상품집합의 관계형태는? : n:n

SELECT * FROM t_giftmem;

SELECT * FROM t_giftpoint;

--카타시안 곱 발생
SELECT *
    FROM t_giftmem, t_giftpoint;
    
SELECT *
    FROM t_giftmem mem, t_giftpoint poi
 WHERE poi.name_vc = '과자종합';
 
--non-equals join이다 (<=, >=로 비교하는)
SELECT *
    FROM t_giftmem mem, t_giftpoint poi
 WHERE poi.name_vc = '과자종합'
      AND poi.point_nu <= mem.point_nu; 
      
--------------Self Join-------------------------------------
SELECT * FROM emp;

SELECT A.ename AS "매니저", b.ename
    FROM emp A, emp b
  WHERE A.empno = b.mgr;

---------------Cross Join--------------------  
SELECT *
    FROM emp CROSS JOIN dept; 

-------실전문제-----------------------------------------------------    
temp와 tdept를 이용하여 다음 컬럼을 보여주는 SQL을 만들어 보자.
상위부서가 'CA0001'인 부서에 소속된 직원을 1.사번, 2.성명, 3.부서코드
4.부서명, 5.상위부서코드, 6.상위부서명, 7.상위부서장아이디, 8.상위부서장성명
순서로 보여주면 된다.

--내 풀이...... 틀림
SELECT P.emp_id, P.emp_name, P.dept_code, t1.dept_name, t2.dept_code, t2.dept_name, t2.DEPT_CODE, P.EMP_NAME
    FROM temp P, tdept T1, tdept t2
 WHERE T1.PARENT_DEPT = T2.DEPT_CODE
      AND P.dept_code = t1.dept_code
      AND T2.BOSS_ID =  P.emp_id
      AND t2.dept_code = 'CA0001';
      
-- 선생님 풀이
SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
    FROM temp NATURAL JOIN tdept;

SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
    FROM temp A, tdept b
 WHERE A.dept_code = b.dept_code;
 
-- 조인  조건의 숫자: 테이블 갯수에서 n-1
SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
                , c.dept_code AS "상위부서코드"
                , c.dept_name AS "상위부서명"
    FROM temp A, tdept b, tdept c
 WHERE A.dept_code = b.dept_code
      AND b.parent_dept = c.dept_code
      AND c.dept_code = 'CA0001';
      
SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
                , c.dept_code AS "상위부서코드"
                , c.dept_name AS "상위부서명"
                , C.BOSS_ID AS "상위부서장아이디"
                , d.emp_name AS "상위부서장이름"
    FROM temp A, tdept b, tdept c, temp d
 WHERE A.dept_code = b.dept_code
      AND b.parent_dept = c.dept_code
      AND c.boss_id = d.emp_id
      AND c.dept_code = 'CA0001';