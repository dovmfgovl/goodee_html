-- ����� ���� �����ϱ�

CREATE user plum IDENTIFIED BY plum;

-- ����� �������� Ŀ�ؼ� ����ϱ�

GRANT connect, RESOURCE TO plum;

GRANT CREATE SEQUENCE TO plum;

GRANT CREATE TABLE TO plum WITH ADMIN OPTION;

GRANT CREATE VIEW TO plum;