-- memory�� ����� SQL ����Ȯ���ϴ� sql�� - DBA ���� ����
--����Ŭ �������� v$sqlarea view�� ���� Oracle Memory�� ����Ǿ� �ִ� SQL ������ Ȯ���� �� �ִ�.

SELECT sql_text, sharable_mem, executions
    FROM v$sqlarea
 WHERE sql_text LIKE 'SELECT ename%';