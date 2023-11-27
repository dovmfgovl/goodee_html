CREATE OR REPLACE PROCEDURE SCOTT.proc_loop1(dan IN number)
IS
    n_i number(2);
BEGIN
    --파라미터에 선언된 변수는 재정의 불가함
    n_i :=1;
    dbms_output.put_line(dan||'단을 출력합니다.');
    LOOP
        dbms_output.put_line(dan||'*'||n_i||'='||(dan*n_i));
        n_i := n_i + 1;
        IF n_i > 9 THEN
            exit;
         END IF;
     END LOOP;
END;
/