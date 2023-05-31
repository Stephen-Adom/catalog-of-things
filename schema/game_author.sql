--- author table ---
CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    fist_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

--- game table ---
create TABLE game(
 id serial primary key,
 multiplayer boolean not null,
 last_played date not null,
 publish_date date not null,
 archived boolean not null,
 author_id int references author(id),
 genre_id int references genre(id),
 source_id int references source(id),
 label_id int references label(id)
);
