CREATE OR REPLACE PROCEDURE proc_empcursor(rc_emp OUT sys_refcursor)
IS
BEGIN
    OPEN rc_emp
    FOR SELECT empno, ename, sal, hiredate FROM emp;
END;
/