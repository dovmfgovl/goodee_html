--�ο� ������ �ִ� ���� �÷� ������ �Ű� ����ϱ�
--UI�ַ�� + DataSet ����

--�������� : ����, �ʱ�ȭ, ��ġ

SELECT 1, 2, 3 FROM dual;

SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual;

UI/VIEW ����
��µǴ� ������ ���� : ���̺� ���� �״�� ��µǴ� ���� ����

������ �����ϸ鼭 ����ϱ� : �ζ��κ�

SELECT *
    FROM sw_design;
    
SELECT dap FROM sw_design;

2=2 r1:= r1+1;
3=3 r1:=r1+1;
4=1 w1:=w1+1;
1=1 r1:=r1+1;

SELECT 1, 2, 3 FROM sw_design;

SELECT ceil(d_no/4), 2, 3 FROM sw_design
GROUP BY ceil(d_no/4);

--�Ľ̰����� ����ؾ߸� �׽�Ʈ�� �����ϴ�

SELECT 
              min(decode(d_no, 1, dap)) 
            , min(decode(d_no, 2, dap)) 
            , min(decode(d_no, 3, dap)) 
            , min(decode(d_no, 4, dap)) 
   FROM sw_design
GROUP BY ceil(d_no/4);

SELECT 
              min(decode(d_no, 1, dap)) 
            , min(decode(d_no, 2, dap)) 
            , min(decode(d_no, 3, dap)) 
            , min(decode(d_no, 4, dap)) 
            INTO d1, d2, d3, d4
   FROM sw_design
GROUP BY ceil(d_no/4);

LOOP
    FETCH paper_cursor INTO vexam_no u1, u2, u3, u4;
    exit WHEN paper_cur%NOTFOUND;
    IF u1 = d1 THEN
        r1:=r1+1;
    ELSE
        w1:=w1+1;
    END IF;
END LOOP;

COMMIT;
--���� ������ ä���� ���� ���� �������� �ʱ� ���� ä�� �� �ʱ�ȭ �ؾ� ��
r1:=0;
w1:=0;

CURSOR paper_cur IS
SELECT exam_no, dap1, dap2, dap3, dap4 FROM exam_paper;

FETCH paper_cur INTO vexam_no, u1, u2, u3, u4

UPDATE exam_paper
       set right_answer = r1,
               wrong_answer = w1
  WHERE exam_no = vexam_no;