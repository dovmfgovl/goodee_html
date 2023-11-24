CREATE OR REPLACE PROCEDURE proc_hello(x IN NUMBER, msg OUT varchar2)
IS
A number(5) := 0;
BEGIN
msg('오늘은 '||to_char(sysdate, 'YYYY-MM-DD')||' 입니다');
dbms_output.put_line('hello oracle');
dbms_output.put_line('오늘은 '||to_char(sysdate, 'YYYY-MM-DD')||' 입니다');
END;
/