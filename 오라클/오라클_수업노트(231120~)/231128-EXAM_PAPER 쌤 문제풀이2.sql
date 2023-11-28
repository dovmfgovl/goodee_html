CREATE OR REPLACE PROCEDURE proc_account2(p_examno IN varchar2)
IS
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
BEGIN

END;