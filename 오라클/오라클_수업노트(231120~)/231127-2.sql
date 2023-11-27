CREATE OR REPLACE PROCEDURE proc_exception1
IS
    n_i number(5);
BEGIN
    n_i := 0;
    n_i := '김유신';
    EXCEPTION
        WHEN invalid_number THEN
            dbms_output.put_line('잘못된 숫자값에 대한 에러');
         WHEN value_error THEN
            dbms_output.put_line('잘못된 데이터값에 대한 에러');
         WHEN others THEN
            dbms_output.put_line('잘못된 숫자나 데이터값은 아닌 에러');
END;
/