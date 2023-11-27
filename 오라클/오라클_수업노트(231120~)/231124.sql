--DML
SELECT 
    FROM
 WHERE
 GROUP BY
 [[HAVING]]
 ORDER BY
 
SELECT 컬럼명1, 컬럼명2,.... 함수명(컬럼명3)
    FROM 집합1, 집합2, (SELECT 문 - 인라인뷰)
 WHERE 컬럼명1 = 값(상수만 아니다. select문 - 서브쿼리) : 조건검색, 조인하는 곳
     AND 컬럼명2 = 값(SELECT 문) : AND는 교집합 - 원소가 줄어듦. 경우의 수 감소. 일량 감소 -> 속도 빠름
       OR  컬럼명3 = 값(IN)  : OR는 합집합 - 경우의 수가 계속 증가. 일량 증가(가능하면 사용하지 말 것)
 GROUP BY 컬럼명1, 컬럼명2(단, 그룹함수 아님. GROUP BY 절에 업는 컬럼을 썼을 때)
 [[HAVING]]
 ORDER BY
 
--에러: 단일 그룹의 그룹 함수가 아닙니다
SELECT ename, sum(sal)
    FROM emp;
 
--원하는 값 출력되지 않음  
SELECT max(ename), sum(sal)
    FROM emp
 GROUP BY ename;
 
--GROUP BY절에 여러 개의 조건이 올 수 있다 : 업무에 대한 복잡도 높을수록 조건 증가
SELECT deptno, JOB
    FROM emp
GROUP BY deptno, JOB
ORDER BY deptno;

--sum(decode(...)) 패턴 : 소계, 총계, 계...
SELECT decode(JOB, 'CLERK', sal, NULL)
    FROM emp;
    
SELECT sum(decode(JOB, 'CLERK', sal, NULL))
    FROM emp;
    
SELECT count(empno), count(comm) FROM emp;

---------문제 풀이.....-------------------------무슨 문제....?-------------
SELECT ROWNUM rno FROM temp;

SELECT ROWNUM rno, emp_name FROM temp;

--1, 2, 3이 모두 1이 출력되도록 한다 : 왜냐하면 3개 이름은 모두 첫 줄에 출력해야 하니까
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
 
SELECT '김길동', '홍길동', '박문수' FROM dual
UNION ALL
SELECT ' 정도령', '이순신', '지문덕' FROM dual;

decode(mod(rno, 3),1, '김길동')

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
 --------NATURAL JOIN  변천사---------
SELECT empno, ename, dname
    FROM emp;
    
SELECT empno, ename, dname
    FROM emp, dept; -- 카타시안 곱
    
SELECT empno, ename, dname
    FROM emp NATURAL JOIN dept;
    
SELECT empno, ename, dname
    FROM emp A JOIN dept b
        ON A.deptno = b.deptno;
    
SELECT empno, ename, dname
    FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 -----------------------------------       
---문제----------------
tcom의 work_year = '2001'인 자료와 temp를 사번으로 연결해서 join한 후
comm을 받는 직원의 성명, salary + COMM을 조회해 보시오.

SELECT A.emp_id, A.emp_name, 100+10
    FROM temp A;
    
SELECT A.emp_id, A.emp_name, A.salary+b.comm
    FROM temp A, tcom b
 WHERE A.emp_id = b.emp_id
      AND b.work_year = '2001';

SELECT dept.deptno, emp.ename
    FROM emp, dept
  WHERE emp.deptno = dept.deptno;
      
---위위 쿼리를 내추럴 조인으로 바꾸기
SELECT emp_id, emp_name, salary+comm
    FROM temp NATURAL JOIN tcom
 WHERE work_year = '2001';
 
------문제 -------
temp와 emp_level을 이용해 emp_level의 과장 직급의 연봉 상한/하한 범위 내에 드는 직원의 사번과, 성명, 직급, salary를 읽어보자.

-- 내 풀이
SELECT T.emp_id, T.emp_name, E.lev, T.salary 
    FROM temp T, emp_level E
 WHERE E.lev = T.lev
       AND T.salary BETWEEN 37000000 AND 75000000;
       
--선생님 풀이
SELECT A.emp_id, A.emp_name
    FROM temp A, emp_level b;
    
SELECT A.emp_id, A.emp_name, b.lev
    FROM temp A, emp_level b
 WHERE b.lev = '과장';
 
SELECT count(emp_id) FROM temp WHERE lev='과장';

----최종 답--
SELECT A.emp_id, A.emp_name, A.lev
    FROM temp A, emp_level b
 WHERE b.lev = '과장'
     AND A.salary BETWEEN from_sal AND to_sal; 

--수습사원은 제외  (내풀이)
SELECT A.emp_id, A.emp_name, A.lev
    FROM temp A, emp_level b
 WHERE b.lev = '과장'
     AND A.salary BETWEEN from_sal AND to_sal
     AND A.emp_type NOT IN('인턴');
     
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
 
-------수습사원 상한, 하한 없지만 그래도 보여달라
SELECT b.emp_id, b.emp_name, b.lev, A.from_sal, A.to_sal
    FROM emp_level A, temp b
 WHERE A.lev(+) = b.lev;
 
-------------3. self join---------------------------------------------
문제) tdept테이블에 자신의 상위 부서 정보를 관리하고 있다.
이 테이블을 이용하여 부서코드, 부서명, 상위부서코드, 상위부서명을 읽어오는 
쿼리를 만들어 보자.

--생각하는 과정~~~~~~~
--테이블 하나로는 원하는 값을 출력할 수 없다
SELECT dept_name, parent_dept
    FROM tdept;
    
SELECT dept_name AS "부서명"
              , dept_name AS "상위부서명"
    FROM tdept;
    
SELECT A.dept_name AS "부서명"
      , a.dept_code
     , b.dept_name AS "상위부서명"
     , b.dept_code
    FROM tdept A, tdept b
 order by a.dept_name, b.dept_name;

--둘의 관계형태가 1:n이니 정의를 잘해서 사용해야 한다
SELECT A.dept_name AS "부서명"
      , b.dept_name AS "상위부서명"
    FROM tdept A, tdept b
 WHERE A.parent_dept = b.dept_code;
 
 --~~~~~~~~~~
문제) tdept테이블에 자신의 상위 부서 정보를 관리하고 있다.
이 테이블을 이용하여 부서코드, 부서명, 상위부서코드, 상위부서명을 읽어오는 
쿼리를 만들어 보자.

--내 풀이
SELECT A.dept_code AS "부서코드"
            , A.dept_name AS "부서명"
            , b.parent_dept AS "상위부서코드"
            , b.dept_name AS "상위부서명"
    FROM tdept A, tdept b
 WHERE A.parent_dept = b.dept_code;
 

--------------------------------------------------------------------------------
-----문제 -----outer join 해보기---오라클\오라클실습소스\SQL\04장------
이들 데이터의 작업시간이 짧게 걸리는 시간 순서대로 1부터 15까지의 순위를 
매겨서 출력하시오.

SELECT * FROM t_worktime;

--랭크 함수로 문제 풀이
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
