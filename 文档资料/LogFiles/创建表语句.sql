USE school;

create table User(
    UID INT PRIMARY KEY COMMENT '用户唯一标识',
    UName VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    Password VARCHAR(255) NOT NULL COMMENT '密码',
    Role CHAR(1) NOT NULL COMMENT '用户角色',
    ID INT UNIQUE NOT NULL COMMENT '对应角色标识',

    CONSTRAINT chk_role CHECK (Role IN ('S', 'T', 'A'))
) COMMENT '用户表';

create table Department(
    DID INT PRIMARY KEY COMMENT '学科系标识',
    Name VARCHAR(100) NOT NULL COMMENT '学科系名称',
    DHeadID INT COMMENT '学科系主任'

    /*FOREIGN KEY (DHeadID) REFERENCES Teacher(TID)*/
)COMMENT '学科系表';

create table Teacher(
    TID INT PRIMARY KEY COMMENT '老师唯一标识',
    Name VARCHAR(10) NOT NULL COMMENT '老师姓名',
    Sex CHAR(2) NOT NULL COMMENT '性别',
    Age INT COMMENT '年龄',
    DID INT NOT NULL COMMENT '所属学科系',

    FOREIGN KEY(TID) REFERENCES User(ID),
    CONSTRAINT chk_tsex CHECK ( Sex IN ('男' or '女') ),
    CONSTRAINT chk_tage CHECK ( Age BETWEEN 18 AND 90),
    FOREIGN KEY(DID) REFERENCES Department(DID)
)COMMENT '教师表';

create table Class(
    CLID INT PRIMARY KEY COMMENT '班级唯一标识',
    Name VARCHAR(100) NOT NULL COMMENT '班级名称',
    SNUM INT COMMENT '班级学生数',
    CHeadID INT COMMENT '班长',
    DID INT NOT NULL COMMENT '所属学科系',

    CONSTRAINT chk_snum CHECK ( SNUM BETWEEN 0 AND 60),
    /*FOREIGN KEY (CHeadID) REFERENCES Student(SID),*/
    FOREIGN KEY (DID) REFERENCES Department(DID)
)COMMENT '班级表';

create table Student(
    SID INT PRIMARY KEY COMMENT '学生唯一标识',
    Name VARCHAR(10) NOT NULL COMMENT '学生姓名',
    Sex char(2) NOT NULL COMMENT '性别',
    Age INT COMMENT '年龄',
    CLID INT COMMENT '所在班级',
    DID INT NOT NULL COMMENT '所属学科系',

    FOREIGN KEY (SID) REFERENCES User(ID),
    CONSTRAINT chk_ssex CHECK ( Sex IN ('男' or '女') ),
    CONSTRAINT chk_sage CHECK ( Age BETWEEN 10 AND 80),
    FOREIGN KEY (CLID) REFERENCES Class(CLID),
    FOREIGN KEY (DID) REFERENCES Department(DID)
)COMMENT '学生表';

create table Room(
    RID INT PRIMARY KEY COMMENT '教室唯一标识',
    Location VARCHAR(200) NOT NULL COMMENT '教室位置',
    Capacity INT NOT NULL COMMENT '容量',
    Type VARCHAR(4) NOT NULL COMMENT '教室类型',
    State CHAR(1) NOT NULL DEFAULT 'T' COMMENT '教室状态',

    CONSTRAINT chk_cap CHECK ( Capacity BETWEEN 0 AND 100000),
    CONSTRAINT chk_rtype CHECK ( Type IN ('普通','体育','电脑','物理','化学' OR '天文') ),
    CONSTRAINT chk_state CHECK ( State IN ('T' OR 'F') )
)COMMENT '教室表';

create table Course(
    CID INT PRIMARY KEY COMMENT '课程唯一标识',
    TID INT NOT NULL COMMENT '教师',
    Name VARCHAR(100) NOT NULL COMMENT '课程名称',
    Type VARCHAR(4) NOT NULL COMMENT '课程类型',
    Credits DECIMAL(3,1) NOT NULL COMMENT '学分',
    DID INT NOT NULL COMMENT '所属学科系',

    FOREIGN KEY (TID) REFERENCES Teacher(TID),
    CONSTRAINT chk_ctype CHECK ( Type IN('必修' or '选修') ),
    CONSTRAINT chk_cre CHECK ( Credits BETWEEN 0 AND 100),
    FOREIGN KEY (DID) REFERENCES Department(DID)
)COMMENT '课程表';

create table Enrollment(
    EID INT PRIMARY KEY COMMENT '选课记录标识',
    SID INT NOT NULL COMMENT '学生标识',
    CID INT NOT NULL COMMENT '课程标识',
    Grade DECIMAL(5,2) COMMENT '成绩',

    FOREIGN KEY (SID) REFERENCES Student(SID),
    FOREIGN KEY (CID) REFERENCES Course(CID),
    CONSTRAINT chk_sc UNIQUE (SID,CID)
)COMMENT '选课表';

create table Schedule(
    SCID INT PRIMARY KEY COMMENT '排课唯一标识',
    CID INT NOT NULL COMMENT '对应课程',
    RID INT NOT NULL COMMENT '授课教室',
    SNUM INT COMMENT '学生人数',
    Time DATETIME NOT NULL COMMENT '时间段',

    FOREIGN KEY (CID) REFERENCES Course(CID),
    FOREIGN KEY (RID) REFERENCES Room(RID),
    CONSTRAINT chk_rt  UNIQUE (RID,Time)
)COMMENT '排课表';