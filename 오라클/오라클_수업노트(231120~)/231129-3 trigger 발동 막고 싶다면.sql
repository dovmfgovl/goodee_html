ALTER TRIGGER trg_check DISABLE;

DELETE FROM emp;

ROLLBACK;

--Ʈ���� �����ϰ� ���� �� : �α� ����� �ʹٸ� DROP���ٴ� disable
DROP TRIGGER trg_check;