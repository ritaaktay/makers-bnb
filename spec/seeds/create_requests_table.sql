DROP TABLE IF EXISTS requests;

-- Table Definition
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