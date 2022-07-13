PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;



CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR,
    lname VARCHAR
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    title VARCHAR,
    body VARCHAR,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,


    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    body_reply VARCHAR,

    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (user_id) REFERENCES users(id)
);




INSERT INTO 
 users (fname,lname)
 VALUES
 ('mohamed','salah'),
 ('karen','siu');

 INSERT INTO
 questions (title,body,user_id)
 VALUES
 ('age','how old are you', (SELECT id FROM users WHERE fname = 'mohamed')),

 ('pets','what is your favorite pet', (SELECT id FROM users WHERE fname = 'karen'));


