CREATE TABLE TEST06 (
 YMD    VARCHAR2(08) NOT NULL,
 LEASE  NUMBER,
 CONSTRAINT TEST06_PK PRIMARY KEY (YMD)
);
INSERT INTO TEST06 VALUES ('20010115', 2100000);
INSERT INTO TEST06 VALUES ('20010127', 2400000);
INSERT INTO TEST06 VALUES ('20010316', 2400000);
INSERT INTO TEST06 VALUES ('20010320', 2400000);
INSERT INTO TEST06 VALUES ('20010720', 2300000);
INSERT INTO TEST06 VALUES ('20010731', 2200000);
INSERT INTO TEST06 VALUES ('20010822', 2300000);
INSERT INTO TEST06 VALUES ('20010831', 2200000);
INSERT INTO TEST06 VALUES ('20010906', 2200000);
INSERT INTO TEST06 VALUES ('20010915', 2200000);
COMMIT;
