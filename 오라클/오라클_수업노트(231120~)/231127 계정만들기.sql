-- 사용자 계정 생성하기

CREATE user plum IDENTIFIED BY plum;

-- 사용자 계정으로 커넥션 허용하기

GRANT connect, RESOURCE TO plum;

GRANT CREATE SEQUENCE TO plum;

GRANT CREATE TABLE TO plum WITH ADMIN OPTION;

GRANT CREATE VIEW TO plum;