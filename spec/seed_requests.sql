DROP TABLE IF EXISTS requests;

-- Table Definition
CREATE TYPE status AS ENUM ('confirmed', 'declined', 'pending');
CREATE TABLE requests (
  id SERIAL PRIMARY KEY,
  date date,
  user_id int,
  listing_id int,
  current_status status
);

TRUNCATE TABLE requests RESTART IDENTITY;

INSERT INTO request ('date', 'user_id', 'listing_id', 'current_status') VALUES
(2022-09-20, 1, 1, 'pending'),
(2022-08-20, 1, 1, 'confirmed'),
(2022-09-20, 2, 1, 'declined');