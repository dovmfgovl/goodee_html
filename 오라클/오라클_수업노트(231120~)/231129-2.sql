SELECT nvl((SELECT m_id FROM member1 WHERE m_id=:x), '-1')
        FROM dual;
        
SELECT nvl((SELECT m_id FROM member1 WHERE m_id=:x), '-1') INTO status
        FROM dual;
        
status���� ���̵� �����ϸ� ���̵� ���
�׷��� ���̵� �������� ������ -1�� ���
INTO���� PL/SQL�������� ��� ������ : ����) �����ุ ���� �� ����