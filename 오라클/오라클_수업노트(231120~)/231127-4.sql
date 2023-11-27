CREATE OR REPLACE PROCEDURE proc_raise
 IS
 --변수선언부
    user_excep EXCEPTION; --사용자정의 예외 객체
 BEGIN
    RAISE user_excep;
    EXCEPTION
        WHEN user_excep THEN
            dbms_output.put_line('Raise를 이용한 사용자 예외처리방법');
         WHEN others THEN
            dbms_output.put_line('그 외 예외 처리');
 END;
 /