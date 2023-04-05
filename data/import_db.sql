PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    -- foreign key to questions (not optional)
    -- foreign key to users (author) (not optional)
    -- foreign key to reply it belongs to (optional) (self-referential)
    -- body column
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    reply_id INTEGER,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    -- id
    -- two foreign keys (joins table)
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO 
    users (fname,lname) 
VALUES 
    ('sdf','sdf'),
    ('John', 'Doe'),
    ('Spencer', 'Gigachad'),
    ('Ace', 'OfSpades');

INSERT INTO 
    questions (title,body,user_id)
VALUES  
    ('SQL_HELP!!!!', 'TEACH ME SqL!!!!!', 1);
    
INSERT INTO 
    replies (body,question_id,user_id,reply_id)
VALUES
    ('no',1,3,NULL),
    ('spencer!!',1,4,1);

INSERT INTO 
    question_follows (question_id, user_id)
VALUES
    (1, 1);

INSERT INTO 
    question_likes (question_id, user_id)
VALUES
    (1, 2),
    (1, 4);