CREATE OR REPLACE PROCEDURE proc_account2
IS
    vexam_no varchar2(10);
--수험생이 입력한 1번 답안
    u1 number(1):=0;
--수험생이 입력한 2번 답안
    u2 number(1):=0;
--수험생이 입력한 3번 답안
    u3 number(1):=0;
--수험생이 입력한 4번 답안
    u4 number(1):=0;
--1번 정답
    d1 number(1):=0;
--2번 정답
    d2 number(1):=0;
--3번 정답
    d3 number(1):=0;
--4번 정답
    d4 number(1):=0;
--수험생이 맞춘 정답 수를 담음
    r1 number(3):=0;
--수험생이 틀린 답 수를 담음
    w1 number(3):=0;
    CURSOR paper_cur IS
    SELECT exam_no, dap1, dap2, dap3, dap4 FROM exam_paper;
BEGIN
    SELECT 
              min(decode(d_no, 1, dap)) 
            , min(decode(d_no, 2, dap)) 
            , min(decode(d_no, 3, dap)) 
            , min(decode(d_no, 4, dap)) 
            INTO d1, d2, d3, d4
       FROM sw_design
     GROUP BY ceil(d_no/4);
     OPEN paper_cur;
     --3명 수험생 채점 진행
     LOOP
        FETCH paper_cur INTO vexam_no, u1, u2, u3, u4;
        --무한루프에 대한 방어코드 작성하기
         exit WHEN paper_cur%NOTFOUND; --학생 수 만큼 반복된다 : 3바퀴 돈다
            IF u1 = d1 THEN
                r1:=r1+1;
            ELSE
                w1:=w1+1;
            END IF;
             IF u2 = d2 THEN
                r1:=r1+1;
            ELSE
                w1:=w1+1;
            END IF;
             IF u3 = d3 THEN
                r1:=r1+1;
            ELSE
                w1:=w1+1;
            END IF;
             IF u4 = d4 THEN
                r1:=r1+1;
            ELSE
                w1:=w1+1;
            END IF;
            UPDATE exam_paper
                   set right_answer = r1,
                           wrong_answer = w1
              WHERE exam_no = vexam_no;
              COMMIT;
              r1:=0;
              w1:=0;
     END LOOP;
     CLOSE paper_cur;
END;