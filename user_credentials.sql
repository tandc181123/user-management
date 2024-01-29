CREATE TABLE user_credentials (
    user_name VARCHAR(30) CHECK(LENGTH(user_name) >= 6),
    pass_word VARCHAR(12) CHECK(LENGTH(pass_word) >= 8),
    email VARCHAR(50),
    creation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);