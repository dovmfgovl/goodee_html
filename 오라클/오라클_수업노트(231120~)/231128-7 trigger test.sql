-- 테스트 시나리오
-- 데이터 복제 트리거 적용 여부 확인하기

INSERT INTO dept(deptno, dname, loc) VALUES(70, '전산과', '서울');

SELECT * FROM dept_copy WHERE deptno = 70;

UPDATE dept set loc = '포항' WHERE deptno = 70;

DELETE FROM dept_copy WHERE deptno = 70;