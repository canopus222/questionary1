-- 職業テーブル (occupation)
CREATE TABLE IF NOT EXISTS occupation (
    id   INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL UNIQUE,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 飲み物テーブル (drink)
CREATE TABLE IF NOT EXISTS drink (
    id   INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL UNIQUE,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS member (
    id          INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(60) NOT NULL,
    birthdate   DATE NOT NULL,
    occupation_id INTEGER NOT NULL,
    drink_id     INTEGER NOT NULL,
    remarks     TEXT,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (occupation_id) REFERENCES occupation(id),
    FOREIGN KEY (drink_id) REFERENCES drink(id)
);
