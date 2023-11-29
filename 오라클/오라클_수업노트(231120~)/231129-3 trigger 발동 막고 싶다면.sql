ALTER TRIGGER trg_check DISABLE;

DELETE FROM emp;

ROLLBACK;

--트리거 삭제하고 싶을 때 : 로그 남기고 싶다면 DROP보다는 disable
DROP TRIGGER trg_check;