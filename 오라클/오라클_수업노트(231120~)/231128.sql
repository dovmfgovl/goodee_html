------����-------------
(Ŀ���� ����Ͽ�)
�μ���ȣ�� �Է¹޾�(�Ķ���ͷ� �޾Ƽ� - p_deptno number)
�� �μ��� ��ձ޿�(��������)���� 
���� �޴� ����� 10% �λ��ϰ� ���� �޴� ����� 20% �λ��� �����Ͽ� 
�޿������� ����(UPDATE - COMMIT)�ϴ� ���ν����� �ۼ��Ͻÿ�.

���� �� �б�
1. ������ �� ��� : SELECT ...INTO -> �� ���� �� �Ǹ� ���� ( XXXVO)
���� ���� ���� ó���� �� FETCH...INTO -> �� ��� �����ϱ� - �ݺ��� �����Ͽ� ��� (List<VO>, List<Map>) 
CURSOR ����
--Ŀ�� �����ϱ�
CURSOR emp_cur IS
SELECT empno, ename, sal
    FROM emp
 WHERE deptno = p_deptno;

--�޿������ ���Ѵ�
SELECT avg(sal) INTO avg_sal 
    FROM emp
WHERE deptno = p_deptno;
 
LOOP
FETCH emp_cur INTO v_empno, v_ename, v_sal
    exit WHEN emp_cur%NOTFOUND;
    IF v_sal > avg_sal THEN
        rate :=1.1;
     ELSIF v_sal <= avg_sal THEN
        rate :=1.2;
     END IF;
     UPDATE emp
        set sal = sal * rate
     WHERE empno = v_empno;
 END LOOP;
 
OPEN emp_cur;
CLOSE emp_cur;
���� rate number(3, 1) : 99.9���� ���� �� ����(3�� �� 3 �ڸ����� �ǹ���)
avg_sal number(7, 2) : 99999.99����

SELECT count(empno)
    FROM emp
 GROUP BY deptno;
 
DECLARE --�̸��� ���� : ȣ�� �� ��, ���� �ȵ� -> ���� �̸� �ʿ���
--PL/SQL�� : ����ü(���ν���(���� ����, ���ν��� ȣ�� ����, Ŀ��, �ѹ� ���� ����), �Լ�(��ȯ ���� �ִ�), Ʈ����)
-- Ʈ����:  ȣ������ �ʰ� �ڵ����� �����. ������� ���� �� ��Ȱ��ȭ ���ѵ�
CREATE OR REPLACE [PROCEDURE, FUNCTION, TRIGGER] �̸�
IS
--�����
BEGIN
--���α׷� : ���, DML, commit, rollback, �ݺ���
--���� ���� �� ���� ó���ϱ�
--�ڵ����� ä���ϱ�
    EXCEPTION
END;


SELECT empno, ename, sal
    FROM emp
 WHERE deptno =:x;