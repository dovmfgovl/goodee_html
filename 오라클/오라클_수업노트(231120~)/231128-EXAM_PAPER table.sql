CREATE TABLE SCOTT.EXAM_PAPER
(
  EXAM_NO       VARCHAR2(10 BYTE),
  DAP1          NUMBER(5)                       DEFAULT 0,
  DAP2          NUMBER(5)                       DEFAULT 0,
  DAP3          NUMBER(5)                       DEFAULT 0,
  DAP4          NUMBER(5)                       DEFAULT 0,
  RIGHT_ANSWER  NUMBER(5)                       DEFAULT 0,
  WRONG_ANSWER  NUMBER(5)                       DEFAULT 0
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


CREATE UNIQUE INDEX SCOTT.PAPER_NO_PK ON SCOTT.EXAM_PAPER
(EXAM_NO)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE SCOTT.EXAM_PAPER ADD (
  CONSTRAINT PAPER_NO_PK
  PRIMARY KEY
  (EXAM_NO)
  USING INDEX SCOTT.PAPER_NO_PK)
--  ENABLE VALIDATE);