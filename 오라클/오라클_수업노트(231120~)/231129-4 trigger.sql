CREATE OR REPLACE TRIGGER trg_check
BEFORE UPDATE OR DELETE OR INSERT ON emp
BEGIN
    IF (to_char(sysdate, 'DY') IN ('수', '목'))
    THEN 
        raise_application_error(-20001, '수, 목요일에는 변경할 수 없습니다.');
    END IF;
END;

DELETE FROM emp;