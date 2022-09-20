CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email text UNIQUE,
  password text, 
  username text UNIQUE
);