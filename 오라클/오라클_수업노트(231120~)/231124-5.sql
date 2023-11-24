CREATE OR REPLACE PROCEDURE proc_hap2(msg OUT varchar2)
IS
    n_i number(5) :=0;
    n_hap number(5) :=0;
BEGIN
    FOR n_i IN 1..100 LOOP
        IF mod(n_i, 5) = 0 THEN
            n_hap := n_hap + n_i;
        END IF;
    END LOOP;
    msg :='5의 배수의 합은 '||n_hap||' 입니다.';
END;