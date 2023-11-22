SELECT empno, ename FROM emp;

-- 정렬됨
SELECT empno FROM emp;

-- 정렬 안 됨
SELECT ename FROM emp;

--정렬 되고 안 되고의 이유는 뭘까?
--  실행계획을 떠올려 보면 인덱스를 스캔해서 값을 출력하였다.
--  인덱스는 누가 만들어주나? - 자동으로 제공됨
--   자동으로 만듣 때 정렬이 오름차순인 것 

-- hint문 : 주석처럼 생긴 아이
SELECT
                /*+ ALL_ROWS */ empno
     FROM emp;
     
SELECT /*+index_desc(emp pk_emp) */empno FROM emp;

SELECT ename FROM emp
ORDER BY ename desc;

--------

-- natural join: 양쪽 집합에 있는 것만 나와
SELECT empno, ename, dept.dname
    FROM emp, dept
WHERE emp.deptno = dept.deptno;

--힌트문을 통해 옵티마이저에게 개발자가 생각하는 실행계획을 전달할 수 있다. 만약 오타가 있으면 무시된다.
SELECT /*+ rule */ *
    FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- 해쉬조인 방식은 두 테이블을 각각 통째로 읽어서 먼저 줄을 세운 뒤에 조건을 비교해가며 출력한다.

SELECT rowid rid, ename FROM emp;

--ROWNUM: 조회 결과에 대해 순서를 매길 때 사용함
SELECT ROWNUM rno, ename FROM emp;

SELECT ROWNUM rno, empno, ename
    FROM (
                    SELECT empno, ename FROM emp
                    ORDER BY hiredate desc
                );
                
                
--------------------------------------
-- 그룹함수----------------
SELECT sum(sal)
    FROM emp;
    
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--누구의 이름을 출력해 달라는건지 알 수 없기 때문에 에러 발생
SELECT sum(sal), ename
    FROM emp;
    
-- -> 굳이 출력하고 싶다면 max or min 추가 : 단, sum과 연관없다. W이기에 max 일 때  WARD가 출력되는 것일 뿐
-- ename에 max를 붙인 건 문법적인 문제를 피하기 위함이다. 단지 그것 뿐
SELECT sum(sal), max(ename)
    FROM emp;    
    
SELECT count(comm), max(ename)
    FROM emp;
    
SELECT count(comm), ename
    FROM emp;
 
-- 위 문제를 GRUOP BY로 해결---------------
--ORA-00979: GROUP BY 표현식이 아닙니다. 
--select절에 없는 컬럼을 GROUP BY절에서 사용할 수 없다.
SELECT count(comm), ename
    FROM emp
GROUP BY deptno;

--위 문제 해결
SELECT count(comm), ename
    FROM emp
GROUP BY ename;

SELECT seq_vc
    FROM t_letitbe
WHERE seq_vc > 3;

--ORA-00904: "MNO": 부적합한 식별자
--  alias는 where절에서 쓸 수 없다. 집합에서 제공하는 컬럼이 아니기 때문이다.
SELECT mod(seq_vc, 2) mno
    FROM t_letitbe
WHERE mno > 3;

--<해결방법>
--1) where절에는 mod(seq_vc, 2) 직접 넣어 사용
SELECT mod(seq_vc, 2) mno
    FROM t_letitbe
WHERE mod(seq_vc, 2) = 1 ;

-- 2) 인라인뷰
--  from절에 오기 때문에 테이블이다.
SELECT mno
    FROM (
                    SELECT mod(seq_vc, 2) mno
                        FROM t_letitbe
                )
WHERE mno = 1;

-- <max와 일반 컬럼을 함꼐 사용하지 못하는 문법적인 문제를 해결하는 두 가지 방법>----
1) 너도 그룹함수 씌워라
2) GROUP by절에 너도 써라 : 단, 효과가 전혀 없었다. - 그럼 왜?

SELECT deptno FROM emp;

--아래 둘은 같은 결과 : 중복 제거
SELECT DISTINCT(deptno) FROM emp;

SELECT deptno FROM emp
GROUP BY deptno;
----

--이름의 경우: 중복이 없으니 중복제거는 되지 않는다. 단, 정렬 후 중복값이 있는 찾는 것이기 때문에 정렬하여 출력된다
SELECT ename FROM emp;

SELECT DISTINCT(ename) FROM emp;

SELECT ename FROM emp
GROUP BY ename;

SELECT deptno, sum(sal), count(sal), max(sal), min(sal), avg(sal)
    FROM emp
GROUP BY deptno;

------------------------------------------------------------------------------
--------------조건문-------------------------
SELECT ... FROM 절 사이에 조건문을 사용할 수 있다
1) decode : 크다, 작다는 비교할 수 없다.

SELECT decode(sign(1-2), 1,'앞에 숫자가 크다', -1,'뒤에 숫자가 크다', 0, '같다') FROM dual;

SELECT greatest(1,5,3), least(1,5,3) FROM dual;

2) case문

SELECT deptno, 
       CASE deptno
         WHEN 10 THEN 'ACCOUNTING'
         WHEN 20 THEN 'RESEARCH'
         WHEN 30 THEN 'SALES'
         ELSE 'OPERATIONS'
       END AS "Dept Name"
  FROM dept;
        
        
--------------------------------------실습소스 03-001,002-------------------------------
temp의 자료를 salary로 분류하여 30,000,000이하는 'D',
30,000,000 초과 50,000,000이하는 'C'
50,000,000 초과 70,000,000이하는 'B'
70,000,000 초과는 'A'라고 등급을 분류하여 등급별 인원수를
알고 싶다.

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
   
 -- 4교시 실습문제
 -- 판매날짜, 판매개수, 판매가격 출력 + 총계까지
 --decode는 from절을 제외한 어디서든 사용 가능!!!!!
 --분석함수 사용은 제외하여 구현하기
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

--다음 버전에서 대표가 원하는 정보가 뭘까?
-- 재고파악 - 빠진물품 채워야 한다
SELECT count(qty_nu), sum(qty_nu)
    FROM t_orderbasket;
    
--판매된 수량이 반영되지 않았다 : 단가만 반영된 것이다. 수량 반영되지 않음
SELECT sum(price_nu)
    FROM t_orderbasket;

SELECT sum(price_nu*qty_nu)
    FROM t_orderbasket;
    
SELECT deptno
    FROM emp
 GROUP BY deptno;

부서별 - GROUP BY
분기별
반기별
년도별

날짜별로....

SELECT indate_vc
    FROM t_orderbasket
 GROUP BY indate_vc;

-- 로우를 세는 건 원하는 결과가 아니다
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

--1번은 날짜별 계산할 때 사용하고, 2번은 총계 구할 때 계산값으로 사용한다.
--1)
SELECT indate_vc FROM t_orderbasket,
(SELECT ROWNUM rno FROM dept WHERE ROWNUM <3);

--2)
SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual;
--2)보다 1)이 더 효율적!

--2) 경우의 시각화! 확인해보자
SELECT indate_vc FROM t_orderbasket,
(
SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual
);

--3) 총계 구하기
SELECT decode(A.rno, 1, indate_vc,2, '총계') FROM t_orderbasket,
(
SELECT 1  rno FROM dual
UNION ALL
SELECT 2 FROM dual
)A

SELECT decode(A.rno, 1, indate_vc,2, '총계') FROM t_orderbasket,
(
SELECT 1  rno FROM dual
UNION ALL
SELECT 2 FROM dual
)A
GROUP BY decode(A.rno, 1, indate_vc,2, '총계');

--2개 로우를 추가한 이유는 1번일 땐 날짜별 계산에서 사용하고 2번일 땐 총계 계산 시 사용하겠다
--indate_vc는 varchar라 타입이 동일해서 가능. qty_nu를 넣으면 타입이 달라서 에러 뜸
SELECT decode(A.rno, 1, indate_vc,2, '총계')
    FROM t_orderbasket,
                (
                SELECT 1  rno FROM dual
                UNION ALL
                SELECT 2 FROM dual
                )A
GROUP BY decode(A.rno, 1, indate_vc,2, '총계')
ORDER BY decode(A.rno, 1, indate_vc,2, '총계');

--ORA-00979: GROUP BY 표현식이 아닙니다.
--그룹바이에 오지 않은 일반 컬럼을 쓸 수 없다.
SELECT decode(A.rno, 1, indate_vc,2, '총계'), qty_nu
    FROM t_orderbasket,
                (
                SELECT 1  rno FROM dual
                UNION ALL
                SELECT 2 FROM dual
                )A
GROUP BY decode(A.rno, 1, indate_vc,2, '총계')
ORDER BY decode(A.rno, 1, indate_vc,2, '총계');

--해결 + 문제 답
-- rollup 지원하지 않은 RDBMS라면...!! 결국 이렇게 패턴화해서 사용해야 한다.
SELECT decode(A.rno, 1, indate_vc,2, '총계'), sum(qty_nu), sum(qty_nu*price_nu)
    FROM t_orderbasket,
                (
                SELECT 1  rno FROM dual
                UNION ALL
                SELECT 2 FROM dual
                )A
GROUP BY decode(A.rno, 1, indate_vc,2, '총계')
ORDER BY decode(A.rno, 1, indate_vc,2, '총계');

SELECT max(ename), min(ename) --문법(parsing)적인 문제를 단순히 피하기 위해서 의미없이 사용
    FROM emp
GROUP BY deptno;

SELECT decode(JOB, 'clerk', sal), decode(JOB, 'saleman', sal)
                , decode(JOB

SELECT decode(b.rno,1,indate_vc,2,'총계') AS "판매날짜"
               , sum(qty_nu)||'개' AS "판매개수"
               , sum(qty_nu*price_nu)||'원' AS "판매가격"
FROM t_orderbasket,
        (SELECT ROWNUM rno
        FROM dept
        WHERE ROWNUM <3)b
GROUP BY decode(b.rno,1,indate_vc,2,'총계')
ORDER BY 판매날짜;


 문제) CASE...WHEN  구분을 활용할 것
 member1 테이블을 이용하여 아이디가 존재하지 않으면 -1 을 반환하고
 아이디가 존재하면 비번까지 비교하여 같으면 1을 반환하고
 다르면 0을 반환하는 selelct문을 작성하시오.
 
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

-- -1이면 아이디가 존재하지 않는다
-- 1이면 아이디와 비번이 모두 일치한다
-- 0인 경우는 아이디는 존재하지만 비번은 틀리다
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


--사원번호를 채번하는데 최대값에서 1을 더한 값을 새로운 사원의 사번으로 채번하는 경우를 생각해보면.....
SELECT /*+index_desc(emp pd_emp)*/ empno
    FROM emp;
    
SELECT /*+index_desc(emp pd_emp)*/ empno+1
    FROM emp;
    
SELECT /*+index_desc(emp pd_emp)*/ empno+1
    FROM emp
WHERE ROWNUM = 1;

--------------------------------------------------------------어제(231121 문제)-----------------
 --1)))))))))))))))))))))))))))))))))))))))))))컬럼레벨에 있는 정원숫자를 굳이 로우 레벨에 내려서 출력하시오.
 
 SELECT * FROM test11;
 
--1) 
 decode(rno, 1, '1학년', 2, '2학년', 3, '3학년', 4, '4학년')
 
SELECT dept 
    FROM test11,
                (
                    SELECT ROWNUM RNO FROM DEPT WHERE ROWNUM <= 4
                );
                
SELECT dept , decode(rno, 1, '1학년', 2, '2학년', 3, '3학년', 4, '4학년')
    FROM test11,
                (
                    SELECT ROWNUM RNO FROM DEPT WHERE ROWNUM <= 4
                );
                
--2)                
DECODE(RNO, 1, FRE, 2, SUP, 3, JUN, 4, SEN)

--최종 답
SELECT dept , decode(rno, 1, '1학년', 2, '2학년', 3, '3학년', 4, '4학년'),
                DECODE(RNO, 1, FRE, 2, SUP, 3, JUN, 4, SEN)
    FROM test11,
                (
                    SELECT ROWNUM RNO FROM DEPT WHERE ROWNUM <= 4
                )
ORDER BY DEPT ASC, decode(rno, 1, '1학년', 2, '2학년', 3, '3학년', 4, '4학년');

-------------
--2)))))))))))))))))))))))))))))))))))))))))))))))
1단계 - 조인없이 EMP 집합만으로 할 수 있는만큼만 해본다

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

SELECT '총계' FROM dual;

SELECT '총계'
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
SELECT '총계'
                ,sum(DECODE(JOB, 'CLERK', SAL))
                ,sum(decode(JOB, 'SALESMAN', sal))
                ,sum(decode(JOB, 'clerk', NULL, 'SALESMAN', NULL, sal))
                , sum(sal)
    FROM emp;
    
--문제제기 : 테이블을 한 번만 읽고 처리하는 방법은 없나?
-- 1) 조인을 먼저 걸지말고 부서별이니까 group by 먼저 해볼까?
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
                  
--서브쿼리에서 사용한 컬럼은 주쿼리에서 사용불가하지만
-- 인라인뷰에서 사용한 컬럼은 테이블 위치이므로 사용이 가능하다       
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

--b.rno가 1과 같으면 dname, 2이면 '총계'
SELECT
                decode(b.rno, 1, dname, 2, '총계')
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
GROUP BY  decode(b.rno, 1, dname, 2, '총계')
ORDER BY decode(b.rno, 1, dname, 2, '총계');

--최종 답안
--sum을 해야만 한다!
SELECT
                decode(b.rno, 1, dname, 2, '총계')
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
GROUP BY  decode(b.rno, 1, dname, 2, '총계')
ORDER BY decode(b.rno, 1, dname, 2, '총계');
                  