-- ----------------------------
-- Procedure structure for t4_tags
-- ----------------------------
DROP PROCEDURE IF EXISTS `t4_tags`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `t4_tags`()
BEGIN
	DECLARE s int default 0;
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
	DECLARE up1 int;
	DECLARE up2 int;
	DECLARE up3 int;
	DECLARE up4 int;
	DECLARE up5 int;
	DECLARE un1 int;
	DECLARE un2 int;
	DECLARE un3 int;
	DECLARE un4 int;
	DECLARE un5 int;

	DECLARE items_ids TEXT;
	DECLARE item1_ids TEXT;
	DECLARE item2_ids TEXT;

	DECLARE cur CURSOR FOR SELECT DISTINCT tags FROM item;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET s=1;


	OPEN cur;
	FETCH cur INTO t;
	#SET t='2848370,1477425';
	WHILE s<>1 DO
		IF t<>'' THEN
				SET i=35;
        while i<=42 do
					set week1=i;
					set week2=i+1;
					set ser=i+2;

					SELECT IFNULL(COUNT(id),0) into p1 FROM join_uia WHERE ui_week = week1 and interaction_type in (1,2,3) and i_tags=t AND i_week=week1;
					SELECT IFNULL(COUNT(id),0) into p2 FROM join_uia WHERE ui_week = week2 and interaction_type in (1,2,3) and i_tags=t AND i_week=week1;
					SELECT IFNULL(COUNT(id),0) into p3 FROM join_uia WHERE ui_week = week2 and interaction_type in (1,2,3) and i_tags=t AND i_week=week2;


					SELECT IFNULL(COUNT(id),0) into n1 FROM join_uia WHERE ui_week = week1 and interaction_type=4 and i_tags=t AND i_week=week1;
					SELECT IFNULL(COUNT(id),0) into n2 FROM join_uia WHERE ui_week = week2 and interaction_type=4 and i_tags=t AND i_week=week1;
					SELECT IFNULL(COUNT(id),0) into n3 FROM join_uia WHERE ui_week = week2 and interaction_type=4 and i_tags=t AND i_week=week2;
					
					UPDATE sample SET sj_tags_1_1_p=p3,sj_tags_1_1_n=n3,sj_tags_2_1_p=(p2+p3),sj_tags_2_1_n=(n2+n3),sj_tags_2_2_p=(p1+p2+p3),sj_tags_2_2_n=(n1+n2+n3) WHERE i_tags=t AND serial=ser;

					
					BEGIN
						DECLARE ss int default 0;
						DECLARE uid int;
						DECLARE c int;
						DECLARE cur2 CURSOR FOR SELECT user_id,IFNULL(COUNT(id),0) FROM join_uia WHERE ui_week = week1 and interaction_type in (1,2,3) and i_tags=t AND i_week=week1 GROUP BY user_id;
						DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss=1;
						open cur2;
						FETCH cur2 into uid,c;
						WHILE ss<>1 DO
							UPDATE sample SET usj_tags_1_p=c  WHERE i_tags=t AND serial=ser AND user_id=uid;
							FETCH cur2 into uid,c;
						END WHILE;
						CLOSE cur2;
					END;


					BEGIN
						DECLARE ss int default 0;
						DECLARE uid int;
						DECLARE c int;
						DECLARE cur2 CURSOR FOR SELECT user_id,IFNULL(COUNT(id),0)  FROM join_uia WHERE ui_week = week2 and interaction_type in (1,2,3) and i_tags=t AND i_week=week1 GROUP BY user_id;
						DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss=1;
						open cur2;
						FETCH cur2 into uid,c;
						WHILE ss<>1 DO
							UPDATE sample SET usj_tags_2_p=c  WHERE i_tags=t AND serial=ser AND user_id=uid;
							FETCH cur2 into uid,c;
						END WHILE;
						CLOSE cur2;
					END;

					BEGIN
						DECLARE ss int default 0;
						DECLARE uid int;
						DECLARE c int;
						DECLARE cur2 CURSOR FOR SELECT user_id,IFNULL(COUNT(id),0)  FROM join_uia WHERE ui_week = week2 and interaction_type in (1,2,3) and i_tags=t AND i_week=week2 GROUP BY user_id;
						DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss=1;
						open cur2;
						FETCH cur2 into uid,c;
						WHILE ss<>1 DO
							UPDATE sample SET usj_tags_3_p=c  WHERE i_tags=t AND serial=ser AND user_id=uid;
							FETCH cur2 into uid,c;
						END WHILE;
						CLOSE cur2;
					END;

				BEGIN
						DECLARE ss int default 0;
						DECLARE uid int;
						DECLARE c int;
						DECLARE cur2 CURSOR FOR SELECT user_id,IFNULL(COUNT(id),0)  FROM join_uia WHERE ui_week = week1 and interaction_type=4 and i_tags=t AND i_week=week1 GROUP BY user_id;
						DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss=1;
						open cur2;
						FETCH cur2 into uid,c;
						WHILE ss<>1 DO
							UPDATE sample SET usj_tags_1_n=c  WHERE i_tags=t AND serial=ser AND user_id=uid;
							FETCH cur2 into uid,c;
						END WHILE;
						CLOSE cur2;
					END;


					BEGIN
						DECLARE ss int default 0;
						DECLARE uid int;
						DECLARE c int;
						DECLARE cur2 CURSOR FOR SELECT user_id,IFNULL(COUNT(id),0)  FROM join_uia WHERE ui_week = week2 and interaction_type=4 and i_tags=t AND i_week=week1 GROUP BY user_id;
						DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss=1;
						open cur2;
						FETCH cur2 into uid,c;
						WHILE ss<>1 DO
							UPDATE sample SET usj_tags_2_n=c  WHERE i_tags=t AND serial=ser AND user_id=uid;
							FETCH cur2 into uid,c;
						END WHILE;
						CLOSE cur2;
					END;

					BEGIN
						DECLARE ss int default 0;
						DECLARE uid int;
						DECLARE c int;
						DECLARE cur2 CURSOR FOR SELECT user_id,IFNULL(COUNT(id),0)  FROM join_uia WHERE ui_week = week2 and interaction_type=4 and i_tags=t AND i_week=week2 GROUP BY user_id;
						DECLARE CONTINUE HANDLER FOR NOT FOUND SET ss=1;
						open cur2;
						FETCH cur2 into uid,c;
						WHILE ss<>1 DO
							UPDATE sample SET usj_tags_3_n=c  WHERE i_tags=t AND serial=ser AND user_id=uid;
							FETCH cur2 into uid,c;
						END WHILE;
						CLOSE cur2;
					END;
							
					
					set i=i+1;
        end WHILE;
		END IF;
		FETCH cur INTO t;
	
	END WHILE;
END
;;
DELIMITER ;
CALL `t4_tags`()