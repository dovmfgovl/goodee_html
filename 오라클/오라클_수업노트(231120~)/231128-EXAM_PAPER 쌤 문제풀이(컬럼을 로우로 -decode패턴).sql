SELECT decode(d_no, 1, dap)
    FROM sw_design;
    
SELECT decode(d_no, 1, dap), decode(d_no, 2, dap), decode(d_no, 3, dap), decode(d_no, 4, dap)
    FROM sw_design;
    
SELECT ceil(d_no/4), decode(d_no, 1, dap), decode(d_no, 2, dap), decode(d_no, 3, dap), decode(d_no, 4, dap)
    FROM sw_design;
    
SELECT ceil(d_no/4), decode(d_no, 1, dap), decode(d_no, 2, dap), decode(d_no, 3, dap), decode(d_no, 4, dap)
    FROM sw_design
 GROUP BY ceil(d_no/4);
 
SELECT ceil(d_no/4)
    FROM sw_design
 GROUP BY ceil(d_no/4);
 
SELECT   max(decode(d_no, 1, dap))
                , max(decode(d_no, 2, dap))
                , max(decode(d_no, 3, dap))
                , max(decode(d_no, 4, dap))
    FROM sw_design
 GROUP BY ceil(d_no/4);
 
SELECT ..INTO

SELECT d1, d2, d3, d4
    FROM (
                    SELECT   max(decode(d_no, 1, dap)) d1
                                    , max(decode(d_no, 2, dap)) d2
                                    , max(decode(d_no, 3, dap)) d3
                                    , max(decode(d_no, 4, dap)) d4
                        FROM sw_design
                     GROUP BY ceil(d_no/4)
                );
                

SELECT d1, d2, d3, d4 INTO d1, d2, d3, d4
    FROM (
                    SELECT   max(decode(d_no, 1, dap)) d1
                                    , max(decode(d_no, 2, dap)) d2
                                    , max(decode(d_no, 3, dap)) d3
                                    , max(decode(d_no, 4, dap)) d4
                        FROM sw_design
                     GROUP BY ceil(d_no/4)
                );
    