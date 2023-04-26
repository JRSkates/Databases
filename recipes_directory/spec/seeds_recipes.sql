TRUNCATE TABLE recipes RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Pizza', 12, 5);
INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Spagehtti Bolognese', 15, 4);
INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Red Thai Curry', 20, 4);
INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Hot Dog', 7, 3);
INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Steak and Ale Pie', 30, 1);