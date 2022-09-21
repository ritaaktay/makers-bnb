TRUNCATE TABLE spaces RESTART IDENTITY;

INSERT INTO spaces (user_id, name, description)
  VALUES (1, 'Super fancy awesome apartment',
          'The best in the neighbourhood, large fridge and awesome view.'),
         (2, 'Small house, oh no',
          'Big bed, small storage, microwave does not work.'),
         (3, 'Nice big farm', 'Lovely animals, and comfy bed.'),
         (4, 'Even nicer farm!', 'Has its own heli pad!'),
         (1, 'Small, humble castle', 'Room service available, but only 2 pools');
