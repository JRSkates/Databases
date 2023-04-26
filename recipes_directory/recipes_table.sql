CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  dish_name text,
  average_cooking_time int,
  rating int
);

INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Pizza', 12, 5);
INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Spagehtti Bolognese', 15, 4);
INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Red Thai Curry', 20, 4);
INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Hot Dog', 7, 3);
INSERT INTO recipes (dish_name, average_cooking_time, rating) VALUES ('Steak and Ale Pie', 30, 1);