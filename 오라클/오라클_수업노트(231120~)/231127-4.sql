CREATE OR REPLACE PROCEDURE proc_raise
 IS
 --���������
    user_excep EXCEPTION; --��������� ���� ��ü
 BEGIN
    RAISE user_excep;
    EXCEPTION
        WHEN user_excep THEN
            dbms_output.put_line('Raise�� �̿��� ����� ����ó�����');
         WHEN others THEN
            dbms_output.put_line('�� �� ���� ó��');
 END;
 /