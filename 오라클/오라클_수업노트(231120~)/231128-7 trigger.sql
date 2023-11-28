CREATE OR REPLACE TRIGGER trg_deptcopy
AFTER 
INSERT OR UPDATE OR DELETE ON dept
FOR EACH ROW -- 이걸 반드시 붙여야 new, old 사용 가능
BEGIN
    IF INSERTING THEN
        INSERT INTO dept_copy(deptno, dname, loc)
        VALUES(:NEW.deptno, :NEW.dname, :NEW.loc);
     ELSIF UPDATING THEN
        UPDATE dept_copy
        set dname = :NEW.dname, loc = :NEW.loc
        WHERE deptno = :OLD.deptno;
     ELSIF deleting THEN
        DELETE FROM dept_copy
        WHERE deptno = :OLD.deptno;
    END IF;
END;