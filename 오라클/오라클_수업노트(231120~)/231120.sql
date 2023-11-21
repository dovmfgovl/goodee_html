--DML : 데이터 조작어

SELECT * FROM TEMP;

SELECT * FROM TDEPT;

SELECT
                ENAME
    FROM EMP;
 
 --테이블을 드라이브 할 때 인덱스 정보 읽는다
 --테이블을 엑세스 하지 않고도 인덱스 정보만으로도 조회됨  
    
 --테이블을 엑세스하지 않고도 
 
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
    
-- 옵티마이저가 조건을 만족하는 정보를 직접 찾아온다
-- 병렬처리 지원, 클러스터 지원

SELECT
                ENAME
    FROM EMP
    
    ORDER BY EMPNO DESC; 

-- 테이블 스키마
--pk, 데이터타입, 인덱스, 제약조건, 물리적인 위치
-- DML(SELECT - 실력차이 나는 부분) - 조건검색 또한
-- 옵티마이저가 일을 함
-- 일의 순서가 있다. - 속도차이가 난다
--FROM절에 테이블이 여러 개(조인 - 객체모델설계) 올 수 있다 : 누가 먼저 할래? - 순서에 따라 속도 차이 남
--ROWID가 있다 - 18자리

--<ROWID 정리>
--DBMS가 가지고 있는 모든 데이터 각각의 고유한 식별자다

SELECT
                 deptno, dname, loc
  FROM emp;
  
  --카타시안 곱 : 집합을 복제하여 총합, 소계, 계 구할 때 사용
  --왜 복제인가? 하나의 값이 총계에서 한 번, 소계에서 한 번, 계 한 번
  --같은 값이 4번 사용되어야 하는 경우.. 사용
  -- 한 명의 사원이 근무할 수 있는 부서의 종류가 모두 출력됨 
  SELECT
                dept.dname, emp.deptno, dept.deptno
  FROM emp, dept;
  
  --쓰레기 값이 포함되어 있어 제거해줘야 함(의미없는 데이터가 있을 수 있다)
  -- -> Natural Join 사용!
  
  --1:n의 관계에 있다 - 이런 경우
  SELECT
                dept.dname, emp.deptno, dept.deptno
  FROM emp, dept
  WHERE emp.deptno = dept.deptno;
  
  DELETE FROM dept WHERE deptno IN(60, 80, 90);
  
  COMMIT;
  
  SELECT * FROM dept;
  
  ROLLBACK;
  
  -- select 뒤에는 컬럼명이 온다 - 여러 개가 올 수 있다 - 부적합한 식별자: 컬럼명이 문제다
  --select문 뒤에 연산처리도 가능하다.
  
  SELECT 1+2, 2*3, 10/2 FROM dual;
  
  --그룹합수 : max, min, avg()
  --왜 그룹함수라고 할까?
  
  --컬럼명이 오는 자리에 함수를 중첩해서 사용할 수 있다.--그룹합수 : max, min, avg()
  --왜 그룹함수라고 할까?
  SELECT count(empno) FROM emp;
  
  SELECT count(comm) FROM emp;
  
  SELECT max(sal), min(sal) FROM emp;
  
  --단일 그룹함수가 아닙니다.
  SELECT max(sal), min(sal), ename FROM emp;
  
  --from절 뒤에는 집합(select문도 가능함 - 인라인뷰 - 중요함)이 온다.
  
  -- where절 : 조건검색 시 사용함
  --where deptno = 10;
  
  
--  1.월 급여는 연봉을 18로 나누어 홀수 달에는 연봉의 1/18이 지급되고, 짝수달에는 연봉의 2/18가 지급된다고 가정했을 때 홀수 달과 짝수 달에 받을 금액을 나타내시오.
SELECT salary FROM temp;

SELECT salary/18, salary*2/18 FROM temp;

SELECT salary/9 FROM temp;

--alias는 ""안에 넣어주는게 정석. "" 넣어주지 않았을 때는 '부서 이름' 과 같이 공백이 있어선 안 됨 
SELECT dname "부서명1", dname AS "부서명2", dname 부서명3 FROM dept;

SELECT salary/18 AS "홀수달급여", salary*2/18 AS "짝수달급여"FROM temp;

--소수점 두 번째 자리에서 반올림하여 소수점 첫째 자리까지 출력
-- -1은 정수의 제일 마지막 자리에서 반올림하여 출력
SELECT round(12345.6789, 1), round(12345.6778, -1), round(12345.6789, 0), round(109, -1) FROM dual;

SELECT round(salary/18, -1) AS "홀수달급여", round(salary/18, 0)
                , round(salary*2/18, -1) AS "짝수달급여"
  FROM temp;

--오라클에서도 형전환 함수가 있다 : 숫자형 -> 문자형으로 바꾼다
--오라클 함수도 파라미터도 있고 리턴값도 있다  (모든 관계지향형 동일)
SELECT sysdate FROM dual;

SELECT sysdate, to_char(sysdate, 'YYYY-MM-DD')
                , to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS AM')
                 , to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM')
                 , to_char(sysdate, 'day')
    FROM dual;

--칼럼수가 증가하면 가로 증가
 SELECT 1,2,3,4,5 FROM dual;
 
 --합집합을 사용하면 세로 증가
 SELECT 1 FROM dual
 UNION ALL
SELECT 2 FROM dual
 UNION ALL
SELECT 3 FROM dual;
--가로로 되어 있는 값을 세로에 출력할 수 있다.
--세로에 있는 값을 가로에 출력할 수 있다.

--중복제거 합집합
--union all : 두 집합 그대로 더함. 중복제거 없음.
--union : 중복 제거. 정렬(값을 비교해서 중복제거하고자 정렬하는 것. 그래서 느림 - 2차 가공)
--union보다 union all이 더 처리 속도 빠르다 : 정렬을 하지 않고 출력하기 때문에

--사용 예시) 과금하기, 배민 1일 정산, 집계(통계), 분포도
SELECT deptno FROM dept
UNION ALL
SELECT deptno FROM emp;

SELECT deptno FROM dept
UNION
SELECT deptno FROM emp;

--차집합
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

--교집합
SELECT deptno FROM dept
INTERSECT
SELECT deptno FROM emp;

-- || : concat
 SELECT  TO_CHAR(round(salary/18,-1), '999,999,999')||'원' AS "홀수달급여"
           ,  round(salary*2/18,-1)||'원' AS "짝수달급여" 
  FROM temp;  
  
--조건에는 
--점조건과 : ==, in구문(or문)
--선분조건이 있다 : between A and B

--2.위에서 구한 월 급여에 교통비가 10만원씩 지급된다면(짝수달은 20만원)위의 문장이 어떻게 바뀔지 작성해 보시오.
SELECT salary/9, (salary/9+100000)*6 AS "홀수달급여", (salary/9+200000)*6 AS "짝수달급여" FROM temp;

 SELECT  TO_CHAR(round(salary/18,-1)+100000, '999,999,999')||'원' AS "홀수달급여"
           , TO_CHAR(round(salary*2/18,-1)+200000, '999,999,999')||'원' AS "짝수달급여" 
  FROM temp;  
  
  SELECT  TO_CHAR(123456789, '999,999')
           ,  TO_CHAR(123456789, '999,999,999')
  FROM dual;  


--3.TEMP 테이블에서 취미가 NULL 이 아닌 사람의 성명을 읽어오시오.
SELECT  EMP_NAME, hobby  FROM temp WHERE hobby IS NOT NULL;

--우리회사 사원 중에서 인센티브를 받지 않는 사람의 이름과 사원번호를 출력하시오.
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

--등산 또는 낚시인 경우
SELECT emp_name, hobby
     FROM temp
WHERE hobby IN('등산', '낚시');

--hobby가 null 또는 등산인 경우
SELECT emp_name, hobby
       FROM temp
 WHERE hobby IN('등산', NULL);
 
SELECT emp_name, hobby
       FROM temp
 WHERE hobby = '등산'
        OR hobby IS NULL;
        
--hobby가 null 또는 '낚시' 모두에 속하지 않는 경우를 구하시오

--not in(null)이 들어있다면 아무 값도 출력되지 않음.
SELECT emp_name, hobby
       FROM temp
 WHERE hobby NOT IN('낚시', NULL);

SELECT emp_name, hobby
    FROM temp
 WHERE hobby <> '낚시' 
        AND hobby IS NOT NULL;

--4.TEMP 테이블에서 취미가 NULL인 사람은 모두 HOBBY를 “없음”이라고 값을 치환하여 가져오고 나머지는 그대로 값을 읽어오시오.
--alias는 더블 퀘테이션, 문자열은 싱글 쿼테이션!!!!!!!!!!!!
SELECT emp_name, nvl(hobby, '없음') FROM temp;

SELECT ename, comm, nvl(comm, 0) FROM emp;

--5.TEMP의 자료 중 HOBBY의 값이 NULL인 사원을 ‘등산’으로 치환했을 때 HOBBY가 ‘등산인 사람의 성명을 가져오는 문장을 작성하시오.
SELECT emp_name, hobby FROM temp
WHERE nvl(hobby, '등산') = '등산';

SELECT ename, empno FROM emp
WHERE empno = 7566;

--데이터베이스에서는 타입을 맞추지 않았어도 자동으로 맞춰줌 (7566이 넘버이지만 VARCHAR 형태로 적어도 묵시적 처리해줌)
SELECT ename, empno FROM emp
WHERE empno = '7566';

SELECT ename, empno FROM emp
WHERE empno = to_number( '7566');

--6.TEMP의 자료 중 EMP_ID와 EMP_NAME을 각각 ‘사번’,’성명’으로 표시되어 DISPLAY되도록 COLUMN ALLIAS를 부여하여 SELECT 하시오.
SELECT emp_id AS "사번", emp_name AS "성명" FROM temp;

--7.TEMP의 자료를 직급 명(LEV)에 ASCENDING하면서 결과내에서 다시 사번 순으로
--DESCENDING하게 하는 ORDER BY하는 문장을 만들어 보시오.
