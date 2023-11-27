CREATE OR REPLACE PROCEDURE proc_login1(p_id IN varchar2, p_pw IN varchar2, r_name OUT varchar2, r_status OUT number)
IS
BEGIN
    SELECT nvl((SELECT mem_id FROM MEMBER1 WHERE mem_id=p_id), -1) INTO r_status
        FROM dual;
END;