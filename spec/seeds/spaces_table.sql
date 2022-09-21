DROP TABLE IF EXISTS spaces;

CREATE TABLE spaces (
    id SERIAL PRIMARY KEY,
    user_id int,
    name text,
    description text,
    constraint fk_user foreign key(user_id)
      references users(id)
      on delete cascade
);
