CREATE OR REPLACE PROCEDURE proc_hap3(msg IN varchar2)
IS
    n_i number(5):=0;
BEGIN
    FOR n_i IN 1..100 LOOP
        IF mod(n_i, 35) = 0 THEN
            dbms_output.put_line('fizzbuzz');
         ELSIF mod(n_i, 5) = 0 THEN
            dbms_output.put_line('fizz');
          ELSIF mod(n_i, 7) =0 THEN
            dbms_output.put_line('buzz');
         ELSE
            dbms_output.put_line(n_i);
         END IF;
         exit WHEN n_i > 50; 
    END LOOP;
END;
          