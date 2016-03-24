-- ----------------------------
-- Procedure structure for `t5`
-- ----------------------------
DROP PROCEDURE IF EXISTS `t5`;
DELIMITER ;;
CREATE DEFINER = `root`@`localhost`
PROCEDURE `t5`()
BEGIN
  #Routine body goes here...
  DECLARE s int DEFAULT 0;
  DECLARE t text;
  DECLARE i int;
  DECLARE week1 int;
  DECLARE week2 int;
  DECLARE ser int;
  DECLARE p1 int;
  DECLARE p2 int;
  DECLARE p3 int;
  DECLARE p4 int;
  DECLARE p5 int;
  DECLARE n1 int;
  DECLARE n2 int;
  DECLARE n3 int;
  DECLARE n4 int;
  DECLARE n5 int;

  DECLARE cur CURSOR FOR
  SELECT DISTINCT
    jobroles
  FROM `user` LIMIT 1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET s = 1;

  OPEN cur;
  FETCH cur INTO t;
  WHILE s <> 1 DO
    IF t <> '' THEN
      SET i = 35;
      WHILE i <= 42 DO
        SET week1 = i;
        SET week2 = i + 1;
        SET ser = i + 2;

        BEGIN
          DECLARE ss int DEFAULT 0;
          DECLARE jid int;
          DECLARE c int;
          DECLARE cur2 CURSOR FOR
          SELECT
            item_id,
            IFNULL(COUNT(id), 0)
          FROM join_uia
          WHERE ui_week = week1
          AND interaction_type IN (1, 2, 3)
          AND u_jobroles = t
          GROUP BY item_id;
          DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss = 1;
          OPEN cur2;
          FETCH cur2 INTO jid, c;
          WHILE ss <> 1 DO
            UPDATE sample
            SET jsu_jr_1_p = c
            WHERE u_jobroles = t
            AND serial = ser
            AND item_id = jid;
            FETCH cur2 INTO jid, c;
          END WHILE;
          CLOSE cur2;
        END;

        BEGIN
          DECLARE ss int DEFAULT 0;
          DECLARE jid int;
          DECLARE c int;
          DECLARE cur2 CURSOR FOR
          SELECT
            item_id,
            IFNULL(COUNT(id), 0)
          FROM join_uia
          WHERE ui_week = week2
          AND interaction_type IN (1, 2, 3)
          AND u_jobroles = t
          GROUP BY item_id;
          DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss = 1;
          OPEN cur2;
          FETCH cur2 INTO jid, c;
          WHILE ss <> 1 DO
            UPDATE sample
            SET jsu_jr_2_p = c
            WHERE u_jobroles = t
            AND serial = ser
            AND item_id = jid;
            FETCH cur2 INTO jid, c;
          END WHILE;
          CLOSE cur2;
        END;

    

        BEGIN
          DECLARE ss int DEFAULT 0;
          DECLARE jid int;
          DECLARE c int;
          DECLARE cur2 CURSOR FOR
          SELECT
            item_id,
            IFNULL(COUNT(id), 0)
          FROM join_uia
          WHERE ui_week = week1
          AND interaction_type = 4
          AND u_jobroles = t
          GROUP BY item_id;
          DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss = 1;
          OPEN cur2;
          FETCH cur2 INTO jid, c;
          WHILE ss <> 1 DO
            UPDATE sample
            SET jsu_jr_1_n = c
            WHERE u_jobroles = t
            AND serial = ser
            AND item_id = jid;
            FETCH cur2 INTO jid, c;
          END WHILE;
          CLOSE cur2;
        END;

        BEGIN
          DECLARE ss int DEFAULT 0;
          DECLARE jid int;
          DECLARE c int;
          DECLARE cur2 CURSOR FOR
          SELECT
            item_id,
            IFNULL(COUNT(id), 0)
          FROM join_uia
          WHERE ui_week = week2
          AND interaction_type = 4
          AND u_jobroles = t
          GROUP BY item_id;
          DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss = 1;
          OPEN cur2;
          FETCH cur2 INTO jid, c;
          WHILE ss <> 1 DO
            UPDATE sample
            SET jsu_jr_2_n = c
            WHERE u_jobroles = t
            AND serial = ser
            AND item_id = jid;
            FETCH cur2 INTO jid, c;
          END WHILE;
          CLOSE cur2;
        END;

        SET i = i + 1;
      END WHILE;
    END IF;
    FETCH cur INTO t;
  END WHILE;

END
;;
DELIMITER ;
call `t5`()