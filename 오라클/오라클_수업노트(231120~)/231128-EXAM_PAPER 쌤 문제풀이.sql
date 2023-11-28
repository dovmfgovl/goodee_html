CREATE OR REPLACE PROCEDURE proc_account1(p_examno IN varchar2, msg OUT varchar2)
IS
--수험생이 입력한 1번 답안
    u1 number(1):=0;
--수험생이 입력한 2번 답안
    u2 number(1):=0;
--수험생이 입력한 3번 답안
    u3 number(1):=0;
--수험생이 입력한 4번 답안
    u4 number(1):=0;
--수험생이 맞춘 정답 수를 담음
    r1 number(3):=0;
--수험생이 틀린 답 수를 담음
    w1 number(3):=0;
    jdap number(2):=0; --커서에서 꺼낸 값 담기
    d_no number(3):=1; --문제번호를 담기
    CURSOR dap_cur IS
    SELECT dap FROM sw_design;
BEGIN
    OPEN dap_cur;
    SELECT dap1, dap2, dap3, dap4 INTO u1, u2, u3, u4
        FROM exam_paper
     WHERE exam_no = p_examno;
    LOOP
        FETCH dap_cur INTO jdap;
        exit WHEN dap_cur%NOTFOUND;
        IF d_no=1 THEN
            IF jdap = u1 THEN
                r1 := r1 +1;
             ELSE
                w1 :=w1 +1;
            END IF;
            ELSIF d_no =2 THEN
                IF jdap = u2 THEN
                    r1 := r1 +1;
                ELSE
                    w1 := w1 +1;
                 END IF;
              ELSIF d_no =3 THEN
                IF jdap = u3 THEN
                    r1 := r1 +1;
                ELSE
                    w1 := w1 +1;
                 END IF;
             ELSIF d_no =4 THEN
                IF jdap = u4 THEN
                    r1 := r1 +1;
                ELSE
                    w1 := w1 +1;
                 END IF;
        END IF;
        d_no := d_no +1;
    END LOOP;
    CLOSE dap_cur;
    msg := '정답 : '||r1|| '오답 : '||w1;
    UPDATE exam_paper
        set right_answer = r1,
                wrong_answer = w1
      WHERE exam_no = p_examno;
      COMMIT;
END;