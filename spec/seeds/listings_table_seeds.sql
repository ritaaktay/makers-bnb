TRUNCATE TABLE listings RESTART IDENTITY;

INSERT INTO listings VALUES (price_per_night, availability, space_id)
  VALUES (25, [
    '2022-09-10', --pending
    '2022-09-11',
    '2022-09-12',
    '2022-09-20', --declined
    '2022-09-21'
    ],
    1),
    (15, [
      '2022-07-10', --pending & declined
      '2022-07-11'
    ],
    2),
    (20, [
      '2022-06-19',
      '2022-10-20', --pending
      '2022-11-20'
    ],
    3),
    (40, [
      '2022-12-24',
      '2022-12-25',
      '2022-12-26'
    ],
    2);