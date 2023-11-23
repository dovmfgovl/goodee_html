문제1:사원번호가 7500번 이상인 사원들의 이름과 입사일자 급여를
출력하시오.

컬럼명: ename, hiredate, sal
조건절: WHERE, HAVING(GROUP BY)
집합명: emp

SELECT ename, hiredate, sal
    FROM emp
WHERE empno >= 7500;
   

문제2:입사한 년도가 1981년인 사원들의 사번을 출력하시오.

hiredate
XXX인 것 - 조건절 : decode, CASE WHEN
empno

--아무 것도 나오지 않음 : 자릿 수가 다르기 때문이다.
SELECT empno
    FROM emp
WHERE hiredate = to_date(1981,  'YYYY');

SELECT hiredate, to_date(1981, 'YYYY')
                , to_date(1981, 'YYYY')-1
    FROM emp;
    
SELECT empno, to_char(hiredate, 'YYYY')
    FROM emp
WHERE '1981' = to_char(hiredate,  'YYYY');

-- 선분조건 - range scan - 구간검색

문제3:사원의 이름이 A로 시작되는 사원들의 사원번호를 
출력하시오.
 --나
SELECT empno
    FROM emp
WHERE ename LIKE 'A%';

--선생님 : 어떤 글자든 검색할 수 있도록 확장!
SELECT empno, ename
    FROM emp
WHERE ename LIKE :x||'%';
 
문제4:입사일자가 1981년 2월1일 에서 1981년 6월30일사이에 
있는 사원들의 사번과 명단을 출력하시오  

SELECT empno, ename, hiredate
 FROM emp
WHERE hiredate BETWEEN '1981/02/01' AND '198-06-30';

--구간검색에서 크거나 같다, 작거나 같다 둘 다 만족해야 한다 : 교집합(INTERSECT) 
문제5:급여가 1000불보다 크거나 같고 3000불보다 작거나 같은
직원들의 이름과 급여를 출력하시오.

SELECT ename, sal
 FROM emp
WHERE sal BETWEEN 1000 AND 3000;

--INTERSECT
SELECT deptno FROM emp
INTERSECT
SELECT deptno FROM dept;

문제6:급여가 3000불이 아닌 사원들의 사번과 이름을 출력하시오.   

--아닌 것을 찾을 때도 index(색인) 사용할 수 있나?
--인덱스를 관리하는 테이블(인텍스키 + rowid)이 있다 : 인덱스만 읽고도 조회가 된다

--<힌트문>
힌트문에 오타가 있으면 무시된다 = 원래 실행계획대로 검색해준다
RDBMS가 세운 실행계획보다 개발자가 세운 실행계획이 옳다고 판단될 때, 옵티마이저에게 내 생각을 전달할 수 있는 유일한 방법

SELECT /*+index_desc(emp pk_emp) */empno
FROM emp;

SELECT empno
    FROM emp;
    
SELECT empno, ename
FROM emp;

--empno는 인덱스가 있다
SELECT empno, ename
    FROM emp
 WHERE empno = 7566;
 
--ename은 인덱스가 없다(조건은 있지만 인덱스는 없기 때문에 인덱스 사용 불가)
SELECT empno, ename
    FROM emp
 WHERE ename = 'SMITH';

--ename에 대한 index 생성    
CREATE INDEX i_ename ON emp(ename ASC);

--인덱스 생성했지만 ename 출력 시 정렬 안 됨. 인덱스가 있지만 사용하지 않음
SELECT ename
    FROM emp;

--인덱스가 필요한 상황에서 사용    
SELECT ename
    FROM emp
 WHERE ename = 'SMITH';

--'아닌 것'을 찾을 때는 인덱스 사용하지 않음
SELECT ename
    FROM emp
 WHERE ename = '';

--인덱스 사용
SELECT ename
    FROM emp
 WHERE ename = ' ';
 
--'아닌 것'을 찾을 때는 index 사용하지 않음 : 이런 강제 조건을 걸어 실행계획 세울 때 index 사용하지 못하도록 만들어 실행속도를 증가시킬 수 있다.
SELECT empno, ename
    FROM emp
 WHERE empno != 7566;
 
--인덱스 사용
SELECT /*+rule */empno, ename
    FROM emp
 WHERE empno = 7566;
 
--인덱스 사용 : '아닌 것'을 찾는데도 사용한다
SELECT  ename
    FROM emp
 WHERE ename != 'SMITH';

--인덱스 미사용 : 위에 hiredate를 select절에 붙이면  인덱스를 사용하지 않는다
SELECT  ename, hiredate
    FROM emp
 WHERE ename != 'SMITH';
 
 
------답--------------
SELECT empno, ename
    FROM emp
WHERE sal <> 3000;

----검증-----
SELECT empno, ename, sal
    FROM emp
WHERE sal <> 3000;
 
문제7:사원들의 부서별 급여평균을 구하시오. 

평균: avg

SELECT sal FROM emp;

SELECT sum(sal), count(sal), count(comm), avg(sal)
    FROM emp;

--에러 발생: 단일 그룹의 그룹 함수가 아닙니다    
SELECT deptno, avg(sal)
    FROM emp;
    
--문법적인 문제만 해결하는 사람
--min이 의미 있는 값인가?
-- : 그룹함수를 사용해 문법적인 문제를 피할 수는 있지만 의미없는 결과다.
-- 의미있는 결과를 보고 싶은 것이라면 group by절을 추가해 유의미한 정보를 출력할 수 있다.
SELECT min(deptno), avg(sal)
    FROM emp;

--문제해결 : GROUP BY    
SELECT deptno, avg(sal)
    FROM emp
GROUP BY deptno;
---------------------------------------------------------------------
--<서브쿼리>
직접적인 조건이 아니라 간접조건을 주고 원하는 결과를 찾아달라고 하면...
위치 파악!
from절에 select문이면 인라인뷰(테이블자리)
    인라인뷰에서 사용한 컬럼명은 별칭이더라도 주 쿼리에서 사용 가능함
조건절에 select문이면 서브쿼리(값)

SELECT words_vc
    FROM t_letitbe;
    
SELECT words_vc
    FROM t_letitbe
 WHERE words_vc LIKE 'Let%';
     
--에러:  "A": 부적합한 식별자 - 인라인뷰에서 사용한 것이여야 주 쿼리에서도 사용 가능
SELECT decode(mod(seq_vc, 2),0, words_vc) A
    FROM t_letitbe
 WHERE A LIKE 'Let%';

--에러 해결: 인라인뷰 사용
SELECT A
    FROM (    
                    SELECT decode(mod(seq_vc, 2),1, words_vc) A
                        FROM t_letitbe
                )
 WHERE A LIKE 'Let%';

문제 1: temp에서 연봉이 가장 많은 직원의 row를 찾아서 이 금액과 동일한 금액을
받는 직원의 사번과 성명을 출력하시오(서브쿼리 활용할 것).

--에러: 단일 그룹의 그룹 함수가 아닙니다
SELECT max(salary), emp_name
    FROM temp;

--사람이 처리한 것..   
SELECT emp_id, emp_name FROM temp
WHERE salary = 100000000;

SELECT emp_id, emp_name FROM temp
WHERE salary = (SELECT 문);

--  서브쿼리 활용 답
SELECT emp_id, emp_name
    FROM temp
 WHERE salary = (SELECT max(salary) FROM temp);
                            

-------                          
2.temp의 자료를 이용하여 salary의 평균을 구하고 이보다 큰 금액을 salary로 
받는 직원의 사번과 성명, 연봉을 보여주시오.

SELECT emp_id, emp_name, salary FROM temp;

SELECT avg(salary) FROM temp;

SELECT emp_id, emp_name, salary
    FROM temp
 WHERE salary > ( SELECT avg(salary) FROM temp);
 
----
3. temp의 직원 중 인천에 근무하는 직원의 사번과 성명을 읽어오는 SQL을 서브
쿼리를 이용해 만들어보시오.

지역 : area

SELECT * FROM tdept;

SELECT dept_code FROM tdept WHERE area = '인천';

SELECT ename, deptno FROM emp
WHERE deptno IN(10, 20);

SELECT emp_id, emp_name
    FROM temp
 WHERE dept_code IN ( SELECT dept_code FROM tdept WHERE area = '인천');
 
 
tcom에 연봉 외에 커미션을 받는 직원의 사번이 보관되어 있다.
이 정보를 서브쿼리로 select하여 부서 명칭별로 커미션을 받는
인원수를 세는 문장을 만들어 보시오.

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

----------------------------실습소스 8-001------------------
도전문제 - 이전 레코드 참조하기

SELECT cdate, amt, crate, lag(crate, 1, 9999) OVER(ORDER BY crate) AS crate_prev
    FROM test02
ORDER BY cdate;

--선생님 풀이
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
                , to_char((A.amt*b.crate), '9,999,999,999')||'원' AS "한화금액"
    FROM (
                    SELECT ROWNUM org_no, cdate, crate, amt FROM test02
                )A,
                (
                    SELECT ROWNUM copy_no, cdate, crate, amt FROM test02
                )b
 WHERE A.org_no-1 = b.copy_no;

-------사용자 정의 함수 만들기--------------231123-2-------------------------- 
SELECT mod(5, 2) FROM dual;

SELECT func_crate('20010906') 
    FROM dual;    
    
    
-----문제--------풀이과정------------------------------------------------------------------------------
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
  SELECT '총계' FROM dual;
  
  54 건이 108건이 되었다.
  54개는 날짜별 계산에 사용되지만 나머지 54개는 총계 하나로 묶는다
  
   SELECT indate_vc FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3); 
   
   SELECT decode(b.rno,1, indate_vc,2,'총계') FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3) b;    
   
     SELECT decode(b.rno,1, indate_vc,2,'총계') FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3) b
   GROUP BY  decode(b.rno,1, indate_vc,2,'총계') ;
   
      SELECT decode(b.rno,1, indate_vc,2,'총계'), sum(qty_nu) FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3) b
   GROUP BY  decode(b.rno,1, indate_vc,2,'총계') ;  
   
      SELECT decode(b.rno,1, indate_vc,2,'총계'), sum(qty_nu) ||'EA' AS "판매수량" FROM t_orderbasket,
   (SELECT ROWNUM rno FROM dept WHERE ROWNUM <3) b
   GROUP BY  decode(b.rno,1, indate_vc,2,'총계') ;     
   
      SELECT decode(b.rno,1, indate_vc,2,'총계')
                 , sum(qty_nu) ||'EA' AS "판매수량" 
         FROM t_orderbasket,
                   (SELECT ROWNUM rno FROM dept 
                     WHERE ROWNUM <3) b
               GROUP BY  decode(b.rno,1, indate_vc,2,'총계') ;    
               
      SELECT decode(b.rno,1, indate_vc,2,'총계') AS "판매날짜"
                 , sum(qty_nu) ||'EA' AS "판매수량" 
         FROM t_orderbasket,
                   (SELECT ROWNUM rno FROM dept 
                     WHERE ROWNUM <3) b
               GROUP BY  decode(b.rno,1, indate_vc,2,'총계') 
            ORDER BY  decode(b.rno,1, indate_vc,2,'총계') ;    
            
      SELECT decode(b.rno,1, indate_vc,2,'총계') AS "판매날짜"
                 , sum(qty_nu) ||'EA' AS "판매수량" 
                 ,sum(qty_nu*price_nu) AS "판매금액"
         FROM t_orderbasket,
                   (SELECT ROWNUM rno FROM dept 
                     WHERE ROWNUM <3) b
               GROUP BY  decode(b.rno,1, indate_vc,2,'총계') 
            ORDER BY  decode(b.rno,1, indate_vc,2,'총계') ;   


SELECT decode(b.rno, 1, indate_vc, 2, '총계', 3, '소계')
                , decode(b.rno, 3, gubun_vc||'계', 1, gubun_vc)
    FROM t_orderbasket,
                (SELECT ROWNUM rno FROM dept 
                  WHERE ROWNUM < 4) b
 GROUP BY decode(b.rno, 1, indate_vc, 2, '총계', 3, '소계')
                                       , decode(b.rno, 3, gubun_vc||'계', 1, gubun_vc)
 ORDER BY decode(b.rno, 1, indate_vc, 2, '총계', 3, '소계');
 
 
--최종 답--
SELECT decode(b.rno, 1, indate_vc, 2, '총계', 3, '소계') AS "판매날짜"
                , decode(b.rno, 3, gubun_vc||'계', 1, gubun_vc) AS "물품구분"
                , sum(qty_nu) AS "판매개수"
                , sum(qty_nu*price_nu) AS "판매가격"
    FROM t_orderbasket,
                (SELECT ROWNUM rno FROM dept 
                  WHERE ROWNUM < 4) b
 GROUP BY decode(b.rno, 1, indate_vc, 2, '총계', 3, '소계')
                   , decode(b.rno, 3, gubun_vc||'계', 1, gubun_vc)
 ORDER BY decode(b.rno, 1, indate_vc, 2, '총계', 3, '소계');
 
 --
 
 SELECT ename
    FROM emp;
    
 SELECT ename
    FROM emp
GROUP BY ename;

 SELECT deptno
    FROM emp
GROUP BY deptno;

--group by의 대상이 아닌 ename을 넣으면 출력이 깨지기 시작 
 SELECT deptno, ename
    FROM emp
GROUP BY deptno, ename;


-----------------어제(231122)-----------문제------
SELECT
      sum(decode(JOB,'CLERK',sal)) clerk_sal
     ,sum(decode(JOB,'SALESMAN',sal)) salesman_sal
     ,sum(decode(JOB, 'CLERK', NULL, 'SALESMAN', NULL, sal)) etc
  FROM scott.emp A, scott.dept b
 WHERE A.deptno = b.deptno  
       
SELECT 
      nvl(decode(b.NO, '1', dname), '총계') dname
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
       (SELECT '1' NO FROM dual --NO로 alias를 1에만 설정한 이유: union all에서 설정한 alias는 첫번째 쿼리 것으로 적용된다
        UNION ALL
        SELECT '2' FROM dual 
       )b     
       GROUP BY decode(b.NO, '1', dname)
ORDER BY dname  

가능하면 테이블은 한 번만 읽어서 처리한다
-> 경우의 수를 줄인다(카디널리티를 줄인다) : 인라인뷰 또는 GROUP BY(조인을 하기 전 미리 그룹핑 한다 - 14건이 3건으로 줄어듦)
-> 조인 한다(그룹핑을 하면서 그룹함수가 필요한 부분(sum(decode패턴))이 있다면 같이 해도 된다.)
->  FROM emp A /   )aa, dept bb : 한 번씩만 테이블을 읽었다
        - 왜 조인을 했나? : 부서번호가 아니라 부서명을 출력하는 것이 직관적이기 때문이다.
-> 더미집합 사용 : 데이터 복제 - 카타시안곱 - 2배수로 복제함

SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;

-> 총계를 넣고 싶은데 deptno이다(타입이 number) - 그래서 총계를 넣지 못 함.
    - 총계 부분을 따로 계싼하여 합집합으로 처리하면 같은 집합은 두 번 읽게 된다. 
    - GROUP BY 하기 전에 먼저 JOIN 한다(decode(dommy.rno, 1, dname, 2, '총계')
--14건을 3건으로 줄이기 위해
--부서명을 얻기 위해 조인 선택
--GROUP BY (decode(b.no, '1', dname)

SELECT 
    (decode(b.NO, 1, A.dname, 2, '총계'))
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
    (decode(b.NO, 1, A.dname, 2, '총계'))
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
 GROUP BY  (decode(b.NO, 1, A.dname, 2, '총계'));
 
 SELECT 
    (decode(b.NO, 1, A.dname, 2, '총계'))
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
 GROUP BY  (decode(b.NO, 1, A.dname, 2, '총계'))
 ORDER BY  (decode(b.NO, 1, A.dname, 2, '총계'));