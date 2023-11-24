CREATE OR REPLACE PROCEDURE proc_dept(x IN number)
IS
    vdname varchar2(20);
    vloc varchar2(30);
BEGIN
    SELECT dname, loc INTO vdname, vloc
        FROM dept
     WHERE deptno = x;
     dbms_output.put_line(vdname||', '||vloc);
END;
