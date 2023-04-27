CREATE TABLE Users (
  id SERIAL PRIMARY KEY,
  username text,
  email text
);

CREATE TABLE Posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  view_count int,

  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);
