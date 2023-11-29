SELECT nvl((SELECT m_id FROM member1 WHERE m_id=:x), '-1')
        FROM dual;
        
SELECT nvl((SELECT m_id FROM member1 WHERE m_id=:x), '-1') INTO status
        FROM dual;
        
status에는 아이디가 존재하면 아이디가 담김
그러나 아이디가 존재하지 않으면 -1이 담김
INTO문은 PL/SQL문에서만 사용 가능함 : 주의) 단일행만 담을 수 있음