use school;

alter table department
add FOREIGN KEY (DHeadID) REFERENCES teacher(TID);

alter table class
add FOREIGN KEY (CHeadID) REFERENCES student(SID);

DELIMITER $$
create trigger chk_snum
    BEFORE INSERT ON schedule
    FOR EACH ROW
    BEGIN
        DECLARE Num INT;
        select room.Capacity INTO Num
        FROM room
        where room.RID = NEW.RID;
        IF NEW.SNUM > Num THEN
            SIGNAL SQLSTATE '45000' /*用于抛出自定义错误，45000 是通用错误代码。*/
            SET MESSAGE_TEXT = '超出教室容量！';
        end IF;
    END$$

DELIMITER ;