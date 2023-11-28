------문제-------------
(커서를 사용하여)
부서번호를 입력받아(파라미터로 받아서 - p_deptno number)
그 부서의 평균급여(변수선언)보다 
많이 받는 사원은 10% 인상하고 적게 받는 사원은 20% 인상을 적용하여 
급여정보를 수정(UPDATE - COMMIT)하는 프로시저를 작성하시오.

문제 잘 읽기
1. 변수에 값 담기 : SELECT ...INTO -> 한 번에 한 건만 가능 ( XXXVO)
만일 여러 건을 처리할 땐 FETCH...INTO -> 한 행식 접근하기 - 반복문 결합하여 사용 (List<VO>, List<Map>) 
CURSOR 정의
--커서 선언하기
CURSOR emp_cur IS
SELECT empno, ename, sal
    FROM emp
 WHERE deptno = p_deptno;

--급여평균을 구한다
SELECT avg(sal) INTO avg_sal 
    FROM emp
WHERE deptno = p_deptno;
 
LOOP
FETCH emp_cur INTO v_empno, v_ename, v_sal
    exit WHEN emp_cur%NOTFOUND;
    IF v_sal > avg_sal THEN
        rate :=1.1;
     ELSIF v_sal <= avg_sal THEN
        rate :=1.2;
     END IF;
     UPDATE emp
        set sal = sal * rate
     WHERE empno = v_empno;
 END LOOP;
 
OPEN emp_cur;
CLOSE emp_cur;
변수 rate number(3, 1) : 99.9까지 담을 수 있음(3은 총 3 자리임을 의미함)
avg_sal number(7, 2) : 99999.99까지

SELECT count(empno)
    FROM emp
 GROUP BY deptno;
 
DECLARE --이름이 없다 : 호출 안 됨, 재사용 안됨 -> 따라서 이름 필요함
--PL/SQL문 : 구조체(프로시저(재사용 가능, 프로시저 호출 가능, 커밋, 롤백 적용 가능), 함수(반환 값이 있다), 트리거)
-- 트리거:  호출하지 않고 자동으로 적용됨. 사용하지 않을 땐 비활성화 시켜둠
CREATE OR REPLACE [PROCEDURE, FUNCTION, TRIGGER] 이름
IS
--선언부
BEGIN
--프로그램 : 사용, DML, commit, rollback, 반복문
--여러 건을 한 번에 처리하기
--자동으로 채점하기
    EXCEPTION
END;


SELECT empno, ename, sal
    FROM emp
 WHERE deptno =:x;