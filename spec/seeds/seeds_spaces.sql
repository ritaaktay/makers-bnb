DROP TABLE IF EXISTS spaces;

CREATE TABLE spaces (
    id SERIAL PRIMARY KEY,
    name text,
    description text
);

TRUNCATE TABLE spaces RESTART IDENTITY;

INSERT INTO spaces (name, description)
  VALUES ('Super fancy awesome apartment',
          'The best in the neighbourhood, large fridge and awesome view.'),
         ('Small house, oh no',
          'Big bed, small storage, microwave does not work.'),
         ('Nice big farm', 'Lovely animals, and comfy bed.');

