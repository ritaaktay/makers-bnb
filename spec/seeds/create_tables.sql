DROP TABLE IF EXISTS requests, listings, users, spaces;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email text UNIQUE,
  password text, 
  username text UNIQUE
);

CREATE TABLE spaces (
    id SERIAL PRIMARY KEY,
    user_id int,
    name text,
    description text,
    constraint fk_user foreign key(user_id)
      references users(id)
      on delete cascade
);

CREATE TABLE listings (
  id SERIAL PRIMARY KEY,
  price_per_night numeric,
  availability date[],
  space_id int,
  constraint fk_space foreign key (space_id) 
    references spaces(id) 
    on delete cascade
);

CREATE TYPE status AS ENUM ('confirmed', 'declined', 'pending');

CREATE TABLE requests (
  id SERIAL PRIMARY KEY,
  date date,
  user_id int,
  listing_id int,
  current_status status,
  constraint fk_user foreign key (user_id)
  references users(id)
  on delete cascade,
  constraint fk_listing foreign key (listing_id)
  references listings(id)
  on delete cascade
);




