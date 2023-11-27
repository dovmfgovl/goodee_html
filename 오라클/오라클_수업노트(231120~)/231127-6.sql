CREATE OR REPLACE PROCEDURE SCOTT.proc_loop2
IS
    n_i number(2);
    tot number(5);
BEGIN
    --파라미터에 선언된 변수는 재정의 불가함
    n_i :=1;
    tot :=0;
    LOOP
        IF mod(n_i, 2)=0 THEN
            tot := tot + n_i;
         END IF;
         n_i := n_i + 1;
         exit WHEN n_i=11;
     END LOOP;
     dbms_output.put_line('짝수의 합은 '||tot);
END;
/