CREATE TABLE listings (
  id SERIAL PRIMARY KEY,
  price_per_night numeric,
  availability date [],
  space_id int,
  constraint fk_space foreign key (space_id) 
    references spaces(id) 
    on delete cascade
);