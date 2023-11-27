CREATE OR REPLACE PROCEDURE proc_errormsg
IS 
--���� �����
    err_num number;
    err_msg varchar2(300);
    n_i number(5) := 0;
BEGIN
--���α׷� �ڵ���
    n_i := 120/0;
    EXCEPTION
        WHEN others THEN
            err_num := SQLCODE;
            err_msg := substr(SQLERRM, 1, 100);
                dbms_output.put_line('�����ڵ� : '|| err_num);
                dbms_output.put_line('�������� : '|| err_msg);
END;
/