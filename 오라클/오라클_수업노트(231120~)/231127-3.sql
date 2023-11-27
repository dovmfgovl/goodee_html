CREATE OR REPLACE PROCEDURE proc_errormsg
IS 
--변수 선언부
    err_num number;
    err_msg varchar2(300);
    n_i number(5) := 0;
BEGIN
--프로그램 코딩부
    n_i := 120/0;
    EXCEPTION
        WHEN others THEN
            err_num := SQLCODE;
            err_msg := substr(SQLERRM, 1, 100);
                dbms_output.put_line('에러코드 : '|| err_num);
                dbms_output.put_line('에러내용 : '|| err_msg);
END;
/