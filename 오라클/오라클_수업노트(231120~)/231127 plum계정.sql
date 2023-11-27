SELECT * FROM member;

edit member;

SELECT * FROM qna;

edit qna;

SELECT * FROM qna_comment;

edit qna_comment;

COMMIT;

SELECT * FROM qna;

SELECT mem_name, qna_content, qna_title
    FROM member M, qna q
  WHERE M.MEM_NO = Q.MEM_NO;
  
SELECT mem_name, qna_content, qna_title
    FROM member NATURAL JOIN qna ;
    
SELECT qna_title, qna_content, mem_name, qc_content
    FROM qna, member, qna_comment qc
  WHERE qna.mem_no = member.mem_no
     AND qna.qna_no = qc.qna_no;
     
SELECT qna_title, qna_content, mem_name, qc_content
    FROM qna, member, qna_comment qc
  WHERE qna.mem_no = member.mem_no
     AND qna.qna_no = qc.qna_no(+);