CREATE OR REPLACE PROCEDURE proc_gugudan(dan IN number)
IS
    n_i number(2);
BEGIN
    n_i :=0;
    dbms_output.put_line(dan||'���� ����մϴ�.');
    FOR n_i IN 1..9 LOOP
        dbms_output.put_line(dan||'*'||n_i||'='||(dan*n_i));
    END LOOP;
END;