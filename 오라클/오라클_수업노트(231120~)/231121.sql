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

--속도향상의 원리 - index, 인라인뷰 원소의 수 줄임(대상 값이 줄어듦)
--pk는 인덱스 제공
--테이블 엑세스 없이도 검색 가능
--fk는 해당없음 - 중복허락

SELECT empno
    FROM emp;
    
 INSERT INTO 집합() VALUES(select문)
 
 SELECT ename, sal FROM emp;
 
 --사원집합 안에 부서명도 넣어줘 : 반정규화 권장하지 않음
 
 --사원수 50만명, 부서종류 100가지
 
 --실행계획 : ctrl + E
 --테이블이 두 개 이상일 때 먼저 읽어들이는 테이블의 순서에 따라 속도 차이 발생함
 
 SELECT 
                emp.empno, emp.ename, dept.dname
    FROM emp, dept
  WHERE dept.deptno = emp.deptno;
  
  
  -------그룹 합수---------------------------------------------------------------------
  
  --max : 전체 범위 처리
  SELECT
                max(sal)
    FROM emp;
    
-- 그룹함수와 일반 칼럼 같이 부르는 것 불법
  SELECT
                max(sal), ename
    FROM emp;

-- 위 문제 해결방법    
--컬럼 자리에 함수를 래핑할 수 있는데 이 때 유효한 정보를 얻기 위해서는 서브쿼리가 필요하다(max월급 받는 사람의 이름을 알고 싶었다면)
  SELECT
                max(sal), max(ename), min(ename)
   FROM emp;
   
   --서브쿼리 활용
 SELECT ename
        FROM emp
    WHERE sal = (SELECT max(sal) FROM emp);
    
-- 부서별 급여 평균을 구하시오
--  : 그룹함수는 전체범위 처리를 한다. 모두 다 따져야해서 속도 느림. 따라서 부분범위 처리 필요.
SELECT sal
    FROM emp;
 
--그룹함수와 일반컬럼은 같이 사용할 수 없다 
 SELECT sal, avg(sal)
    FROM emp;
    
 SELECT avg(sal)
    FROM emp;
 
--distinct : 중복제거   
SELECT DISTINCT(deptno) FROM emp;

SELECT sal
    FROM emp
 GROUP BY dname;
 
SELECT deptno
    FROM emp
 GROUP BY deptno;
 
--having : group by 조건절
SELECT deptno, avg(sal)
    FROM emp
 GROUP BY deptno
 HAVING avg(sal) > 2000;

---------------------------------------------------------------

--1)영어가사만 나오게 하기
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

--선생님 풀이
--테이블에 있는 컬럼만 select 절에 사용 가능 ->
SELECT dname FROM emp;

--따라서 t_letitbe에 없는 컬럼(eng_words)을 select에서 사용할 수 없음
----별칭을 굳이 조건절에서 쓰고 싶다면 인라인뷰 사용하기 ->
SELECT decode(mod(seq_vc, 2),1, words_vc) eng_words
    FROM t_letitbe
WHERE eng_words = 1;

--인라인뷰 사용
SELECT num, eng_words
    FROM (
                    SELECT mod(seq_vc, 2) num
                                     , decode(mod(seq_vc, 2),1, words_vc) eng_words
                         FROM t_letitbe
                 )
 WHERE num = 1;
 
--인라인뷰 사용하지 않은 답
 SELECT decode(mod(seq_vc, 2),1, words_vc) eng_words
    FROM t_letitbe
 WHERE mod(seq_vc, 2) = 1;

--2)한글가사만 나오게 하기
SELECT mod(seq_vc, 2), words_vc FROM t_letitbe
WHERE mod(seq_vc,2) = 0;

-- 선생님 답
 SELECT decode(mod(seq_vc, 2),0, words_vc) han_words
    FROM t_letitbe
 WHERE mod(seq_vc, 2) = 0;

--3)영문가사와 한글 가사 모두 나오게 하기(UNION 사용해서)
--3번 문제의 경우 SELECT * FROM t_letitbe는 답이 아닙니다.
--조건:합집합을 이용하셔야 합니다.
--      정렬 해주셔야 합니다.
--     영문가사와 한글가사 교대로 출력되어야 합니다.
--해당 테이블은 첨부해 드린 오라클 소스 폴더에 SQL에서
--4장에 있는 t_letitbe를 참고하세요
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

--선생님 풀이
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
 
 --위 풀이에서 max 쓰는 이유: 그룹함수와 일반함수는 같이 사용할 수 없다.
-- group by로 seq_vc로 한 그룹을 묶었기 때문에 이 컬럼 외에는 select 절에 올 수 없다. 이 문제를 통과하기 위해 max, min을 써 주는 것.
-- max 주거나 min 주거나 결과에 영향이 없는 건 A컬럼의 문법적인 문제를 해결하는 용도로 사용된 것 뿐이기 때문이다.
 SELECT empno, sum(sal)
    FROM emp;

-- -> 단, group by 절 쓰면 중복 제거(distinct) 되기 때문에 그룹함수와 같이 사용 가능    
 SELECT deptno, sum(sal)
    FROM emp
 GROUP BY deptno;
 
SELECT deptno, sum(sal), max(sal)
    FROM emp
GROUP BY deptno;

--에러(GROUP BY 표현식이 아닙니다.) : 누구의 sal을 구하려는 건지 알 수 없으므로
SELECT deptno, sal
    FROM emp
GROUP BY deptno;

--에러  해결. 단, group by한 효과가 없어진다.
SELECT deptno, sal
    FROM emp
GROUP BY deptno,sal;

-- -> 그러므로 그룹 바이 안 하면 됨
SELECT deptno, sal
    FROM emp;
    
-------231122 내용 추가------------------------------------------------------------------------------------------
--<문제제기>
-- 1. t_letitbe를 두 번 읽어서 처리한다 
-- 2. 왜 별칭을 A로 통일시켰나?
SELECT seq_vc
                , decode(mod(seq_vc, 2), 1, words_vc) A
    FROM t_letitbe
UNION ALL   
SELECT seq_vc
                , decode(mod(seq_vc, 2), 0, words_vc) A
     FROM t_letitbe;
     
--에러: ORA-01790: 대응하는 식과 같은 데이터 유형이어야 합니다
SELECT deptno FROM dept
UNION ALL
SELECT dname FROM dept;

--해결: 타입이 같으면 가능 - 따라서 위 letitbe도 타입이 같으므로 union all  가능
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
--영화 티켓을 받을 수 있는 사람의 명단과 현재 가지고 있는 포인트, 영화 티켓의 포인트
--그리고 그 티켓을 사용한 후 남은 예상 포인트를 출력하시오.

SELECT * FROM t_giftpoint;

SELECT * FROM t_giftmem;

-- <주어진 정보> 
-- 영화티켓 : 15000점
-- 남은 포인트  : 회원보유 포인트 -영화티켓 포인트 = 잔여포인트

--<조건식>
--보유포인트 >= 영화티켓포인트
--WHERE mem.poin_nu >= poi.point_nu

SELECT point_nu
    FROM t_giftpoint
 WHERE name_vc = '영화티켓';

--카타시안의 곱 : 데이터를 복제한다
SELECT *
    FROM t_giftpoint, t_giftmem;
    
SELECT mem.point_nu - poi.point_nu AS "잔여포인트"
    FROM t_giftmem mem, 
                (
                    SELECT point_nu
                        FROM t_giftpoint
                     WHERE name_vc = '영화티켓'
                ) poi
WHERE mem.point_nu >= poi.point_nu;

SELECT mem.name_vc AS "이름"
                , mem.point_nu AS "보유포인트"
                , poi.point_nu AS "적용포인트"
                , mem.point_nu - poi.point_nu AS "잔여포인트"
    FROM t_giftmem mem, 
                (
                    SELECT point_nu
                        FROM t_giftpoint
                     WHERE name_vc = '영화티켓'
                ) poi
WHERE mem.point_nu >= poi.point_nu;

--인라인뷰를 사용하지 않은 답안지
--  Nested loop 조인방식으로 비교한다 : 30가지 경우의 수를 모두 체크하는 것
SELECT mem.name_vc AS "이름"
                , mem.point_nu AS "보유포인트"
                , poi.point_nu AS "적용포인트"
                , mem.point_nu - poi.point_nu AS "잔여포인트"
    FROM t_giftmem mem, t_giftpoint poi
WHERE mem.point_nu >= poi.point_nu
    AND poi.name_vc = '영화티켓';

--문제2
--김유신씨가 보유하고 있는 마일리지 포인트로 얻을 수 있는 상품 중 가장 포인트가 높은 것은 무엇인가?
SELECT point_nu FROM t_giftmem
WHERE name_vc = '김유신';

--max(name_vc)에서 한과세트가 나온 것은 ㅎ으로 시작해서 나온 것임
SELECT max(point_nu)
    FROM t_giftpoint
 WHERE point_nu <= 50012;
 
SELECT name_vc
    FROM t_giftpoint
WHERE point_nu = 50000;

--50000원 자리에 쿼리문을 넣어 답 도출
SELECT name_vc
    FROM t_giftpoint
WHERE point_nu = (
                                        SELECT max(point_nu)
                                             FROM t_giftpoint
                                        WHERE point_nu <= 50012
                                    );

-------------------------------------------------------------------------------------------
-- DECODE는 일반적인 프로그래밍 언어의 if문을 SQL문장 또는 PL/SQL 안으로 끌어들여 사용하기 위해 만들어진 오라클 함수
-- 같은 것만 비교할 수 있다. 크다, 작다는 비교할 수 없다.

--IF A = B THEN
--    RETURN 'T';
--END IF;
--
--DECODE(1, 1, 'T')

--if else: DECODE(1, 2, 'T', 'F')
SELECT DECODE(1, 1, 'T')
              , DECODE(1, 2, 'T', 'F')
    FROM dual;
    
-- 문제1) 주당 강의시간과 학점이 같으면 '일반과목'을 돌려 받고자 한다. 쿼리문을 작성하시오.
--조건절을 만족하지 않는 경우: null을 반환한다. 따라서 아래 두 쿼리문의 결과 값은 동일하다.
SELECT decode(lec_time, lec_point, '일반과목') FROM lecture;

SELECT decode(lec_time, lec_point, '일반과목', NULL) FROM lecture;

-- 문제2) 주당강의시간과 학점이 같은 강의의 숫자를 알고 싶다. 쿼리문을 작성하시오.

--decode를 사용하지 않은 경우
SELECT count(lec_id)
    FROM lecture
WHERE lec_time = lec_point;

--decode를 사용한 경우
--내가 쓴 답안
SELECT count(decode(lec_time, lec_point, lec_id))
    FROM lecture;
    
-- 선생님 답안
--주어지지 않은 조건은 null과 같다. decode(lec_time, lec_point, 1) 여기에서 decode(lec_time, lec_point, 1, null)이 생략되어 있음
SELECT count(decode(lec_time, lec_point, 1))
    FROM lecture;

SELECT decode(lec_time, lec_point, 1)
    FROM lecture;
    
--DECODE를 통해 크다 작다 해보기
-- a-b를 했을 때 -1이 나왔으니 a가 더 작은 수 라는 것을 알 수 있다.
SELECT decode(A-b, -1) FROM dual;

--***sign 함수**
SELECT sign(1+100), sign(-5000), sign(100-100), sign(5000-5000)
    FROM dual;
    
SELECT decode(sign(100-200), 1, '양수', -1, '음수', 0, '0') FROM dual;

--decode: FROM절 빼고는 어디서나 사용할 수 있다.

--null이 있는 경우에 정렬은 어떻게 되나?
--null은 모른다, 결정되지 않았다. 따라서 정렬 할 수 없다. 그래서 맨 뒤에 붙였다.
--null인 컬럼을 내림차순으로 정렬하면 null이 맨 앞에 온다.
SELECT comm
    FROM emp
ORDER BY comm desc;

SELECT comm
    FROM emp
ORDER BY comm ASC;

--문제3) 강의시간과 학점이 같으면 '일반과목'을 리턴 받은 후 정렬도 하고 싶다면?
--강의시간: lec_time
--학점: lec_point
--"같으면" : decode(lec_time, lec_point, '일반과목', null)

--같을 때만 값을 주었으니 다를 때는 무조건 null이다
SELECT decode(lec_time, lec_point, '일반과목')
    FROM lecture;
    
SELECT decode(lec_time, lec_point, '일반과목')
    FROM lecture
ORDER BY decode(lec_time, lec_point, '일반과목') desc;  

SELECT decode(lec_time, lec_point, '일반과목', NULL)
    FROM lecture
ORDER BY decode(lec_time, lec_point, '일반과목') ASC;

--문제4) 월요일엔 해당일자에 01을 붙여서 4자리 암호를 만들고, 
--화요일엔 11, 수요일엔 21, 목요일엔, 31, 금요일엔 41, 토요일엔 51,
--일요일엔 61을 붙여서 4자리 암호를 만든다고 할 때 
--암호를 SELECT하는 SQL을 만들어 보시오.(decode를 활용하여)

--형전환 함수
-- to_char
-- to_number
-- to_date
SELECT to_char(sysdate, 'YYYY-MM-DD') FROM dual;

--UI(User Interface or View 계층) 받아오는 값인 경우가 대부분이다(받아온 값이 문자열이다)
--따라서 to_date는 잘 사용하지 않음.
SELECT sysdate-1, sysdate+2 FROM dual;

<input TYPE="text" NAME="start_day">

SELECT to_date('2023-11-23')+1 FROM dual;

SELECT to_char(sysdate, 'day') FROM dual;

SELECT decode(to_char(sysdate, 'day'), '화요일', '11', '나머지')
    FROM dual;
    
SELECT to_char(sysdate, 'dd') FROM dual;

SELECT to_char(sysdate, 'dd')||'11' FROM dual;

SELECT decode(to_char(sysdate, 'day'), '월요일', '01'
                                                                         , '화요일', '11'
                                                                          , '수요일', '21'
                                                                          , '목요일', '31'
                                                                          , '금요일', '41'
                                                                          , '토요일', '51'
                                                                          , '일요일', '61')
     FROM dual;

SELECT to_char(sysdate, 'dd')||
                decode(to_char(sysdate, 'day'), '월요일', '01'
                                                                          , '화요일', '11'
                                                                          , '수요일', '21'
                                                                          , '목요일', '31'
                                                                          , '금요일', '41'
                                                                          , '토요일', '51'
                                                                          , '일요일', '61') sec_key
       FROM dual;

-- 문제5) 강의시간과 학점이 같거나 강의시간이 학점보다 작으면 '일반과목'을 돌려받고 강의시간이 학점보다 큰 경우만 '실험과목'이라 돌려받고 싶다면 어떻게 처리할 수 있을까?
--내 풀이
SELECT lec_id, lec_time, lec_point, decode(sign(lec_time-lec_point),0, '일반과목',-1, '일반과목',1, '실험과목')
    FROM lecture;

-- 선생님 풀이 
SELECT decode(sign(lec_time-lec_point) , 1, '실험과목', '일반과목') FROM lecture;

-- 문제5-1) lec_time이 크면 '실험과목', lec_point가 크면 '기타과목', 둘이 같으면 '일반과목'으로 값을 돌려 받고자 한다. 쿼리문을 작성해보시오.
SELECT lec_id, lec_time, lec_point, decode(sign(lec_time-lec_point), 1, '실험과목', -1, '기타과목', 0, '일반과목')
    FROM lecture;

--실전문제
--문제 : 사원테이블에서 job이 clerk인 사람의 급여 합,  salesman인 사람의
--급여의 합을 구하고 나머지 job에 대해서는 기타 합으로 구하시오(단, 모든 테이블은 한 번만 읽고 처리할 것).
--<힌트>
SELECT decode(JOB, 'clerk', sal, NULL)
    FROM emp;
    
SELECT decode(JOB, 'clerk', sal, NULL)
                , decode(JOB, 'salesman', sal, NULL)
    FROM emp;
    
SELECT decode(JOB, 'clerk', sal, NULL)
                , decode(JOB, 'salesman', sal, NULL)
                , decode(JOB, 'clerk', NULL, 'salesman', NULL, sal)
    FROM emp;
    
--선생님 풀이
SELECT decode(JOB, 'clerk', sal)
    FROM emp;
    
SELECT sum(decode(JOB, 'clerk', sal)), max(sal), count(empno)
    FROM emp;
    
SELECT count(empno) FROM emp;

SELECT decode(JOB, 'clerk', sal)
                , decode(JOB, 'salesman', sal, NULL)
    FROM emp;

--empno는 다른 값들과 아무 관련 없다
--empno에 max 함수를 씌우는 건 문법적인 문제를 해결하기 위해서일 뿐
SELECT max(empno),
                count(decode(JOB, 'clerk', sal, NULL))
                , sum(decode(JOB, 'clerk', sal, NULL))
                , count(decode(JOB, 'salesman', sal, NULL))
                , sum(decode(JOB, 'salesman', sal, NULL))
    FROM emp;

--*****************sum(decode 패턴) - 자주 나옴!!!************************--------
    
SELECT 
                sum(decode(JOB, 'clerk', sal, NULL))
                , sum(decode(JOB, 'salesman', sal, NULL))
                , sum(decode(JOB, 'clerk', NULL, 'salesman', NULL, sal)) etc_sal
                , sum(sal)
    FROM emp;
    
--실전문제 2) 
--로우에 있는 이름을 컬럼레벨에 나는 출력할 수도 있다.
--emp 테이블의 사원 이름을 한 행에 사번, 성명을 3명씩 보여주는 query문을 작성하시오.
SELECT ename
    FROM emp
WHERE ename = ntitle(3);
 
--사전학습문제
--각 행에 1학년부터 4학년까지 분리 한 행에 하나의 학년만 나오도록 (6장-06-002)
--현재는 로우에 학년별 정원 -> 컬럼으로 학년별 정원이 나오도록 변환
--제목: 컬럼레벨에 있는 학과별 정원 수를 굳이! 로우레벨로 내려서 출력하시오.

SELECT * FROM test11;

SELECT 