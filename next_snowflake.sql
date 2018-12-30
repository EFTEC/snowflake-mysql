DELIMITER $$
CREATE FUNCTION `next_snowflake`(node integer) RETURNS BIGINT(20)
BEGIN
    -- based on yejianfei/snowflake-mysql https://github.com/yejianfei/snowflake-mysql/blob/master/LICENSE
    -- IT HAS A PROBLEM OF CONCURRENCY. The limit is up to 4096 transactions every 1/1000th of a second.
    DECLARE epoch BIGINT(20);
    DECLARE current_ms BIGINT(20);
    DECLARE incr BIGINT(20);

    SET current_ms = round(UNIX_TIMESTAMP(CURTIME(4)) * 1000);
    SET epoch = 1459440000000; #//change your epoch
    
    REPLACE INTO tb_tickets (stub) VALUES ('a');
    SELECT LAST_INSERT_ID() INTO incr;
    
    
RETURN (current_ms - epoch) << 22 | (node << 12) | (incr % 4096);
END$$
DELIMITER ;
