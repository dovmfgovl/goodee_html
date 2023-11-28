CREATE OR REPLACE PROCEDURE proc_deptDelete(p_deptno IN number)
IS
BEGIN
    DELETE FROM dept WHERE deptno = p_deptno;
    COMMIT;
END;