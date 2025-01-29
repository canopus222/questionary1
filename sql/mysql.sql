CREATE TABLE IF NOT EXISTS member (
    id          INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    age         INTEGER NOT NULL,
    occupation  ENUM('会社員', '自営業', '学生', '主婦（夫）', 'その他') NOT NULL,
    drink       ENUM('ビール', 'ワイン', 'シャンパン', '日本酒', '紹興酒', '焼酎', 'ウイスキー') NOT NULL,
    remarks     TEXT
)
