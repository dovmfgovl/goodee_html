-- memory에 실행된 SQL 문장확인하는 sql문 - DBA 권한 가짐
--오라클 관리자의 v$sqlarea view를 보면 Oracle Memory에 저장되어 있는 SQL 구문을 확인할 수 있다.

SELECT sql_text, sharable_mem, executions
    FROM v$sqlarea
 WHERE sql_text LIKE 'SELECT ename%';