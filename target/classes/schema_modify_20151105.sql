DROP TRIGGER IF EXISTS approval_OnInsert;
DROP TABLE IF EXISTS approval;
DROP TRIGGER IF EXISTS approval_line_OnInsert;
DROP TABLE IF EXISTS approval_line;
DROP TABLE IF EXISTS employee;

COMMIT;

CREATE TABLE approval (
	rowid 			VARCHAR(16) NOT NULL,
	appid 			VARCHAR(16) NOT NULL,
	subject 		VARCHAR(255),
	content 		BLOB,
	delflg		    BOOLEAN		NOT NULL DEFAULT 0,
	createdby 		VARCHAR(16) NOT NULL,
	modifiedby		VARCHAR(16),
	createddate 	DATETIME,
	modifieddate 	DATETIME,

	CONSTRAINT pk_approval PRIMARY KEY (rowid, appid)
) ENGINE=INNODB DEFAULT CHARSET = UTF8 COMMENT='approval_parent';

CREATE UNIQUE INDEX par_app_rowid ON approval (rowid);
CREATE INDEX par_app_appid ON approval (appid);

CREATE
    TRIGGER approval_OnInsert BEFORE INSERT
            ON approval FOR EACH ROW
    SET
        NEW.createddate = NOW()
;

CREATE TABLE approval_line (
	rowid 			VARCHAR(16) NOT NULL,
	appid 			VARCHAR(16) NOT NULL,
	seq				INT			NOT NULL DEFAULT 0,
	linetype		VARCHAR(15)	NOT NULL,
	empno			VARCHAR(16),
	delflg		    BOOLEAN		NOT NULL DEFAULT 0,
	createdby 		VARCHAR(16) NOT NULL,
	createddate 	DATETIME,
	modifiedby		VARCHAR(16),
	modifieddate 	DATETIME,

	CONSTRAINT pk_approvalline PRIMARY KEY (rowid),
	FOREIGN KEY (appid) REFERENCES approval (appid)
) ENGINE=INNODB DEFAULT CHARSET = UTF8 COMMENT='approval_child_lines';

CREATE INDEX par_appline_rowid ON approval (rowid);

CREATE
    TRIGGER approval_line_OnInsert BEFORE INSERT
            ON approval_line FOR EACH ROW
    SET
        NEW.createddate = NOW()
;


CREATE TABLE employee (
	rowid 			VARCHAR(16) NOT NULL,
	empid 			VARCHAR(16) NOT NULL,
	depcd			VARCHAR(15),
	cmpid			VARCHAR(15),
	poscd			VARCHAR(15),
	korname			VARCHAR(200),
	engname			VARCHAR(200),
	gender			VARCHAR(15),
	address			VARCHAR(254),
	phone			VARCHAR(30),
	createdby 		VARCHAR(16) NOT NULL,
	createddate 	DATETIME	NOT NULL,
	modifiedby		VARCHAR(16),
	modifieddate 	DATETIME,

	CONSTRAINT pk_Approvalline PRIMARY KEY (rowid, empid)
)  ENGINE=INNODB DEFAULT CHARSET = UTF8 COMMENT='employee master';

CREATE TABLE customer (
	rowid 			VARCHAR(16) NOT NULL,
	id 				VARCHAR(16) NOT NULL,
	firstname		VARCHAR(50),
	lastname		VARCHAR(50),
	companyname		VARCHAR(100),
	corpregnumber	VARCHAR(30),
	type			VARCHAR(30),
	status			VARCHAR(30),
	grade			VARCHAR(30),
	addressid		VARCHAR(16),
	phonenumber		VARCHAR(50),
	email			VARCHAR(30),
	createdby 		VARCHAR(16) NOT NULL,
	modifiedby		VARCHAR(16) NOT NULL,
	createddate 	DATETIME	NOT NULL,
	modifieddate 	DATETIME	NOT NULL,

	CONSTRAINT pk_customer PRIMARY KEY (rowid, id)
) ENGINE=INNODB DEFAULT CHARSET = UTF8 COMMENT='customer_parent';

CREATE INDEX par_customer_rowid ON customer (rowid);

COMMIT;
