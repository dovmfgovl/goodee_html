edit exam_paper;

SELECT * FROM exam_paper;

-- �� Ǯ��....�ϴ� ��
CREATE OR REPLACE PROCEDURE proc_exam_paper(p_exam_no IN number)
IS
    --������� ���
    avg_dap number(2):=0;
    --Ŀ������ ������ �����ȣ ���
    v_exam_no number(10):=0;
    --Ŀ������ ������ ���� ���
    v_right_answer number(2):=0;
    --Ŀ������ ������ ���� ���
    v_wrong_answer number(2):=0;
    --Ŀ�� �����ϱ�
    CURSOR exam_cur IS
    SELECT exam_no
        FROM exam_paper
      WHERE  exam_no = p_exam_no
BEGIN
    SELECT avg(dap1+dap2+dap3+dap4) INTO avg_dap
        FROM exam_paper
     WHERE exam_no = p_exam_no

END;