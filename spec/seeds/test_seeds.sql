TRUNCATE TABLE listings, users, requests, spaces RESTART IDENTITY;

INSERT INTO users (username, email, password)
 VALUES ('Rita Aktay', 'rita@gmail.com', 'istabul97'),
        ('Thomas Mannion', 'thomas@gmail.com', 'coffee'),
        ('D Dramchev', 'dimitar@gmail.com', 'coding123'),
        ('Guillermina Lorenzo', 'guille@gmail.com', 'birthday');

INSERT INTO spaces (user_id, name, description)
  VALUES (1, 'Super fancy awesome apartment',
          'The best in the neighbourhood, large fridge and awesome view.'),
         (2, 'Small house, oh no',
          'Big bed, small storage, microwave does not work.'),
         (3, 'Nice big farm', 'Lovely animals, and comfy bed.'),
         (4, 'Even nicer farm!', 'Has its own heli pad!'),
         (1, 'Small, humble castle', 'Room service available, but only 2 pools');

INSERT INTO listings (price_per_night, availability, space_id)
  VALUES (25, ARRAY [
    DATE '2022-09-10', 
    DATE '2022-09-11',
    DATE '2022-09-12',
    DATE '2022-09-20', 
    DATE '2022-09-21'
    ],
    1),
    (15, ARRAY [
      DATE '2022-07-10',
      DATE '2022-07-11'
    ],
    2),
-- separate dates unavailable(start date - end date)
    (20, ARRAY [
      DATE '2022-06-19',
      DATE '2022-10-20',
      DATE '2022-11-20'
    ],
    3),
    (40, ARRAY [
      DATE '2022-12-24',
      DATE '2022-12-25',
      DATE '2022-12-26'
    ],
    2);

INSERT INTO requests (date, user_id, listing_id, current_status) VALUES
    ('2022-09-10', 1, 1, 'pending'),
    ('2022-09-15', 1, 1, 'confirmed'),
    ('2022-09-20', 2, 1, 'declined'),
    ('2022-07-10', 3, 2, 'pending'),
    ('2022-07-10', 2, 2, 'declined'),
    ('2022-06-20', 1, 3, 'confirmed'),
    ('2022-10-20', 1, 3, 'pending'),
    ('2022-10-20', 2, 3, 'pending'),
    ('2022-10-20', 3, 3, 'pending');



