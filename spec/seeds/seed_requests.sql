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

TRUNCATE TABLE requests RESTART IDENTITY;

INSERT INTO requests ("date", "user_id", "listing_id", "current_status") VALUES
('2022-09-10', 1, 1, 'pending'),
('2022-09-15', 1, 1, 'confirmed'),
('2022-09-20', 2, 1, 'declined'),
('2022-07-10', 3, 2, 'pending'),
('2022-07-10', 2, 2, 'declined'),
('2022-06-20', 1, 3, 'confirmed'),
('2022-10-20', 1, 3, 'pending'),
('2022-10-20', 2, 3, 'pending'),
('2022-10-20', 3, 3, 'pending');