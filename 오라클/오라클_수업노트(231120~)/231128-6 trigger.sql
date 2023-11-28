CREATE OR REPLACE TRIGGER trg_dept
  BEFORE
  UPDATE OR DELETE OR INSERT ON dept
DECLARE
  msg varchar2(200):='';
BEGIN
  IF UPDATING THEN
    dbms_output.put_line('===> UPDATE');
  END IF;
  IF deleting THEN
    dbms_output.put_line('===> DELETE');
  END IF;
  IF INSERTING THEN
    dbms_output.put_line('===> INSERT');
  END IF;
END;