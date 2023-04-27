TRUNCATE TABLE posts RESTART IDENTITY CASCADE; 

INSERT INTO posts (title, content, view_count, user_id ) VALUES ('Jacks Trip to the Zoo', 'I saw a penguin it was great', 15, '1');
INSERT INTO posts (title, content, view_count, user_id ) VALUES ('Title coming soon', 'Content also coming soon', 4, '2');
INSERT INTO posts (title, content, view_count, user_id ) VALUES ('How I scored a goal', 'Just kick the ball', 5467, '3');