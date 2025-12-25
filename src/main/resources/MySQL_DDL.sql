-- ====== employee

DROP TABLE IF EXISTS employee_address;
DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
    id                INT         NOT NULL AUTO_INCREMENT,
    uuid              VARCHAR(64) NOT NULL DEFAULT (UUID()),

    employee_no       INT         NOT NULL,

    first_name        VARCHAR(64) NOT NULL,
    middle_name       VARCHAR(32)          DEFAULT NULL,
    last_name         VARCHAR(64) NOT NULL,

    -- common columns for all tables
    status            TINYINT     NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE (uuid),
    UNIQUE (employee_no)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;


-- ====== address

DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS employee_address;

CREATE TABLE address
(
    id                INT          NOT NULL AUTO_INCREMENT,

    address_line      VARCHAR(255) NOT NULL,
    address_line2     VARCHAR(255)          DEFAULT NULL,

    unit_number       VARCHAR(32)           DEFAULT NULL,

    city              VARCHAR(128) NOT NULL,
    state             VARCHAR(128)          DEFAULT NULL,
    postal_code       VARCHAR(32)  NOT NULL,
    country_code      CHAR(3)      NOT NULL COMMENT 'ISO-3166-1 alpha-2',

    type              TINYINT      NOT NULL DEFAULT 0 COMMENT '0=default, 1=home, 2=business, 4=office',
    comments          VARCHAR(256)          DEFAULT NULL,
    is_primary        BOOLEAN      NOT NULL DEFAULT FALSE,

    -- common columns for all tables
    status            TINYINT      NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    INDEX (postal_code),
    INDEX (country_code)
) ENGINE = INNODB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;


-- ====== employee_address

DROP TABLE IF EXISTS employee_address;

CREATE TABLE employee_address
(
    id                INT       NOT NULL AUTO_INCREMENT,
    employee_id       INT       NOT NULL,
    address_id        INT       NOT NULL,

    -- common columns for all tables
    status            TINYINT   NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (employee_id) REFERENCES employee (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;

-- ====== project

DROP TABLE IF EXISTS project;

CREATE TABLE project
(
    id                INT          NOT NULL AUTO_INCREMENT,
    uuid              VARCHAR(64)  NOT NULL DEFAULT (UUID()),

    name              VARCHAR(255) NOT NULL,
    code              VARCHAR(255)          DEFAULT NULL,
    description       VARCHAR(4096)         DEFAULT NULL,

    start_date        DATETIME              DEFAULT NULL,
    end_date          DATETIME              DEFAULT NULL,

    -- common columns for all tables
    status            TINYINT      NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE (uuid),
    INDEX (name),
    INDEX (code)
) ENGINE = INNODB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;


-- acl user
DROP TABLE IF EXISTS acl_user_group;
DROP TABLE IF EXISTS acl_user_group_target;
DROP TABLE IF EXISTS acl_user;
CREATE TABLE acl_user
(
    id                INT          NOT NULL AUTO_INCREMENT,
    uuid              VARCHAR(64)  NOT NULL DEFAULT (UUID()),

    name              VARCHAR(128) NOT NULL,
    description       VARCHAR(1024)         DEFAULT NULL,

    -- common columns for all tables
    status            TINYINT      NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE (uuid),
    UNIQUE (name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;


-- acl group.
DROP TABLE IF EXISTS acl_user_group;
DROP TABLE IF EXISTS acl_user_group_target;
DROP TABLE IF EXISTS acl_group;
CREATE TABLE acl_group
(
    id                INT          NOT NULL AUTO_INCREMENT,
    uuid              VARCHAR(64)  NOT NULL DEFAULT (UUID()),

    name              VARCHAR(128) NOT NULL,
    description       VARCHAR(1024)         DEFAULT NULL,

    -- common columns for all tables
    status            TINYINT      NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE (uuid),
    UNIQUE (name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;


-- acl_user_group
DROP TABLE IF EXISTS acl_user_group;
CREATE TABLE acl_user_group
(
    id                INT       NOT NULL AUTO_INCREMENT,
    user_id           INT       NOT NULL,
    group_id          INT       NOT NULL,
    description       VARCHAR(1024)      DEFAULT NULL,

    -- common columns for all tables
    status            TINYINT   NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (user_id) REFERENCES acl_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES acl_group (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;


-- acl_target.
DROP TABLE IF EXISTS acl_user_group_target;
DROP TABLE IF EXISTS acl_target;
CREATE TABLE acl_target
(
    id                INT          NOT NULL AUTO_INCREMENT,
    uuid              VARCHAR(64)  NOT NULL DEFAULT (UUID()),

    name              VARCHAR(128) NOT NULL,
    category          VARCHAR(64)  NOT NULL,
    sub_category      VARCHAR(64)  NOT NULL,
    type              VARCHAR(64)  NOT NULL,
    sub_type          VARCHAR(64)  NOT NULL,

    description       VARCHAR(1024)         DEFAULT NULL,

    -- common columns for all tables
    status            TINYINT      NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE (uuid),
    UNIQUE (name),

    INDEX (category),
    INDEX (sub_category),
    INDEX (type),
    INDEX (sub_type)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;


-- acl_user_group_target
DROP TABLE IF EXISTS acl_user_group_target;
CREATE TABLE acl_user_group_target
(
    id                INT        NOT NULL AUTO_INCREMENT,
    user_id           INT                 DEFAULT 0,
    group_id          INT                 DEFAULT 0,
    target_id         INT        NOT NULL,

    privilege         BIGINT(20) NOT NULL,
    description       VARCHAR(1024)       DEFAULT NULL,

    -- common columns for all tables
    status            TINYINT    NOT NULL DEFAULT 0,
    last_updated_time TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (user_id) REFERENCES acl_user (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES acl_group (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (target_id) REFERENCES acl_target (id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000000
  DEFAULT CHARSET = utf8mb4;