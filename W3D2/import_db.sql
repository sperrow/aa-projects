DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  followed_by_id INTEGER NOT NULL,

  FOREIGN KEY (followed_by_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  liked_by_id INTEGER NOT NULL,

  FOREIGN KEY (liked_by_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Matt', 'Sperry'),
  ('Ashley', 'Johnson');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('How do I SQL?',
    'Please halp, I don''t know nothing.',
    (SELECT id FROM users WHERE fname = 'Ashley')),
  ('When are you getting better coffee?',
    'It is not good, please fix this or else I will freak out.',
    (SELECT id FROM users WHERE fname = 'Matt')),
  ('NEW COFFEE??!!',
    'It is not good, please fix this or else I will freak out.',
    (SELECT id FROM users WHERE fname = 'Matt'));

INSERT INTO
  replies (question_id, author_id, parent_id, body)
VALUES
  (2, 1, null, 'Sorry about the coffee'),
  (2, 1, 1, 'Next week!'),
  (2, 2, 2, 'I like the shitty coffee!!');

INSERT INTO
  question_follows (question_id, followed_by_id)
VALUES
  (1, 2),
  (2, 1),
  (2, 2);

INSERT INTO
  question_likes (question_id, liked_by_id)
VALUES
  (1, 2),
  (1, 1),
  (2, 1),
  (2, 1),
  (2, 1);
