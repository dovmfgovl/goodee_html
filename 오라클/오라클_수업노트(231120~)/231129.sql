--로우 레벨에 있는 값을 컬럼 레벨로 옮겨 출력하기
--UI솔루션 + DataSet 매핑

--변수선언 : 기준, 초기화, 위치

SELECT 1, 2, 3 FROM dual;

SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual;

UI/VIEW 계층
출력되는 디자인 패턴 : 테이블 구조 그대로 출력되는 경우는 없다

구조를 변경하면서 출력하기 : 인라인뷰

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

--파싱과정을 통과해야만 테스트가 가능하다

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
--다음 수험자 채점에 대해 점수 누적되지 않기 위해 채점 후 초기화 해야 함
r1:=0;
w1:=0;

CURSOR paper_cur IS
SELECT exam_no, dap1, dap2, dap3, dap4 FROM exam_paper;

FETCH paper_cur INTO vexam_no, u1, u2, u3, u4

UPDATE exam_paper
       set right_answer = r1,
               wrong_answer = w1
  WHERE exam_no = vexam_no;