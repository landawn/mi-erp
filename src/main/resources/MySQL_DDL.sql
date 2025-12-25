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
    last_updated_time TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uk_uuid (uuid),
    UNIQUE KEY uk_employee_id (employee_no)
) ENGINE = InnoDB
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
    is_primary        BOOLEAN      NOT NULL DEFAULT TRUE,

    -- common columns for all tables
    last_updated_time TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    KEY idx_postal (postal_code),
    KEY idx_country (country_code)
) ENGINE = INNODB
  DEFAULT CHARSET = UTF8MB4;


-- ====== employee_address

DROP TABLE IF EXISTS employee_address;

CREATE TABLE employee_address
(
    id                INT       NOT NULL AUTO_INCREMENT,
    employee_id       INT       NOT NULL,
    address_id        INT       NOT NULL,

    -- common columns for all tables
    last_updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employee (id) ON UPDATE RESTRICT ON DELETE CASCADE,
    CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES address (id) ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ====== project

DROP TABLE IF EXISTS project;

CREATE TABLE project
(
    id                INT          NOT NULL AUTO_INCREMENT,
    uuid              VARCHAR(64)  NOT NULL DEFAULT (UUID()),

    name              VARCHAR(255) NOT NULL,
    code              VARCHAR(255)          DEFAULT NULL,

    start_date        DATETIME              DEFAULT NULL,
    end_date          DATETIME              DEFAULT NULL,

    -- common columns for all tables
    last_updated_time TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_time      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uk_uuid (uuid),
    KEY idx_name (name),
    KEY idx_code (code)
) ENGINE = INNODB
  DEFAULT CHARSET = UTF8MB4;

