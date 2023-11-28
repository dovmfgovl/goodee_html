edit exam_paper;

SELECT * FROM exam_paper;

-- 내 풀이....하는 중
CREATE OR REPLACE PROCEDURE proc_exam_paper(p_exam_no IN number)
IS
    --평균점수 담기
    avg_dap number(2):=0;
    --커서에서 꺼내온 수험번호 담기
    v_exam_no number(10):=0;
    --커서에서 꺼내온 정답 담기
    v_right_answer number(2):=0;
    --커서에서 꺼내온 오답 담기
    v_wrong_answer number(2):=0;
    --커서 선언하기
    CURSOR exam_cur IS
    SELECT exam_no
        FROM exam_paper
      WHERE  exam_no = p_exam_no
BEGIN
    SELECT avg(dap1+dap2+dap3+dap4) INTO avg_dap
        FROM exam_paper
     WHERE exam_no = p_exam_no

END;