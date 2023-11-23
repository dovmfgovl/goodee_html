CREATE OR REPLACE FUNCTION func_crate(pdate varchar2)
RETURN number
IS
    tmp number;
BEGIN
    tmp :=0;
    SELECT crate INTO tmp
        FROM test02
      WHERE cdate = (SELECT max(cdate) FROM test02
                                        WHERE cdate < pdate);
    RETURN tmp;
END;