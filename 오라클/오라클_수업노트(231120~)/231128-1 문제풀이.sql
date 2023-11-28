CREATE OR REPLACE PROCEDURE proc_emp_update2(p_deptno IN number)
IS
 --��ձ޿����
    avg_sal number(7, 2):=0.0;
    --Ŀ������ ������ �����ȣ ���
    v_empno number(5):=0;
    --Ŀ������ ������ �޿� ���
    v_sal number(7, 2):=0;
    --Ŀ������ ������ �̸� ���
    v_ename varchar2(20):='';
    rate number(3, 1):=0;
    --Ŀ�� �����ϱ�
    CURSOR emp_cur IS
    SELECT empno, ename, sal
        FROM emp
     WHERE deptno = p_deptno;
BEGIN
    SELECT avg(sal) INTO avg_sal 
         FROM emp
      WHERE deptno = p_deptno;
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_empno, v_ename, v_sal;
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
    COMMIT;
    CLOSE emp_cur;
    EXCEPTION
        WHEN no_data_found THEN
            NULL;
END;