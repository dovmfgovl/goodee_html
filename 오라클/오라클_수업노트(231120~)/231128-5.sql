exec proc_deptUpdate(53, 'DBA', '��õ');

ROLLBACK;

ALTER TRIGGER Ʈ���Ÿ� DISABLE | ENABLE

Ʈ���Ÿ� �������� �� �� �ִ�

ALTER tigger Ʈ���Ÿ� COMPILE;

Ʈ���� �����ϱ�

DROP TRIGGER Ʈ���Ÿ�;

���ν����� Ʈ���� ���ϱ� - ������

DELETE FROM dept WHERE deptno = 53;

ALTER TRIGGER trg_dept DISABLE;

CREATE TABLE dept_copy AS
SELECT * FROM dept;

Ʈ����(TRIGGER)
�� ���̺� ��¥�� ����� �÷��� �ִٰ� �������� �� �� �÷��� 
�����ʹ� �׻� ����ϰ� �Ͽ��ϸ� �ԷµǾ�� �Ѵٰ� ���� �� 
��õ������ ���� �� �ִ� ����� �ִ�.

Ʈ���Ÿ� �̿��ؼ� UPDATE, INSERT�ÿ� �ش� �÷��� �����͸� 
checking�ϸ� �ȴ�. �� INSERT, DELETE, Update�ÿ� �׻� Ư�� ���̺�
�۾����࿡ ���� history�� �ʿ��� ��쿡��  Trigger�� ����ϸ�, ������
�۾����̵� Trigger���� �̸� ���� �� �� �ִ�.

[Syntax]
CREATE TRIGGER Ʈ���Ÿ�
  BEFORE (OR AFTER)
  UPDATE OR DELETE OR INSERT ON ���̺��
  [FOR EACH ROW]
DECLARE
  ���������
BEGIN
  ���α׷� �ڵ���
END;

������ Create�� ���� ���� BEFORE�� UPDATE, DELETE, Insert�� ����
�����ͺ����� ����� ���� �ǹ��ϰ�, AFTER�� �ݴ븦 �ǹ��Ѵ�.
�ַ� BEFORE�� ����ϴµ�, Trigger�� ����ϴ� �ָ����� �߸��� �����͸�
������ ���ε�, �̸� Checking �ϱ� ���ؼ��� BEFORE�� �����ϴ�.

�� �ɼ����� FOR EACH ROW�� �ִµ�, �̰��� ������ ó���ÿ� �ǰ��� ��� 
Trigger�� ����ȴٴ� �ǹ��̴�.
���� �ǰ��� �۾��� ������ �ƴ϶�� ������� �ʴ� ���� ����.
�ֳ��ϸ� FOR EACH ROW�� ����ʿ� ���� �ʿ䰡 �ֵ�  ���� �ǰ��� �۾��ÿ�
����ؼ� Trigger�� �߻��Ǳ� ������ �ʿ���� �����ͺ��̽��� ���� �ϱ� 
�����̴�.

FOR EACH ROW�� �������� ��쿡�� Trigger���� ������ ������ �Ӽ��� ����
�Ѵ�. UPDATE, DELETE, Insert�� ��� �����͸� �����ϴ� SQL���̱� ������
�׻� �ݿ��� �����Ϳ� �ݿ� �� �����͸� �з��� �� �ִ�.

���� ��� Insert�� ���� ��쿡�� ���� ����� ���̱� ������ �ݿ� ��
�����ʹ� �ƹ� �͵� ���� ���̰�, �ݿ� �� �����ʹ� �ش� �����Ͱ� �ǰ���
DELETE�� �ݴ� �����̰�, Update�� �����̱� ������ �翬�� �������� ������
�� �з��� �� �ִ�.

�ٷ� �� �ݿ����� �ݿ� ���� �÷� ������ ���� FOR EACH ROW ���� �Ŀ� 
������ �� �ִ�.

:OLD.�÷��� => SQL�ݿ� �� �ش� �÷� ������
:NEW.�÷��� => SQL���� �� �ش� �÷� ������