PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL, 
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