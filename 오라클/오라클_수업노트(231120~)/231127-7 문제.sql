CREATE OR REPLACE PROCEDURE proc_emp_sal(p_empno IN number,  msg OUT varchar2)
IS
    ename varchar2(30):='';
    sal number(7):=0;
    avg_sal number(10, 2):=0;
    rate number(5, 2):=0;
BEGIN
    SELECT ename, sal INTO ename, sal
        FROM emp
      WHERE empno = p_empno;
     SELECT avg(sal) INTO avg_sal
        FROM emp
      WHERE deptno = (SELECT deptno FROM emp WHERE empno = p_empno);
     IF sal > avg_sal THEN
        rate:=1.1;
     ELSE
        rate:=1.2;
     END IF;
     UPDATE emp
        set sal = sal * rate
      WHERE empno = p_empno;
     COMMIT;
     msg:=ename||' 사원의 '||sal||' 급여가 '||rate||'인상분으로 '||sal*rate||' 으로 인상되었습니다.';
END;
/