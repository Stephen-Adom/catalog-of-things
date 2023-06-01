-- Creating a Lable Table
CREATE TABLE "Label" (
  "id" bigserial,
  "title" varchar(150),
  "color" varchar(100),
  PRIMARY KEY ("id")
);

-- Creating a Book Table
CREATE TABLE "Book" (
  "id" bigserial,
  "genre_id" int,
  "author_id" int,
  "label_id" int,
  "publish_date" date,
  "archived" bool,
  "publisher" varchar(200),
  "cover_state" varchar(10),
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_Book.label_id"
    FOREIGN KEY ("label_id")
      REFERENCES "Label"("id")
);

-- Creating an Authors Table
CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    fist_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Creating a Game Table
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

-- Creating an music albums Table
CREATE TABLE "music_albums" (
  "id" serial integer,
  "item_id" integer,
  "on_spotify" boolean,
  "publish_date" datetime,
  PRIMARY KEY ("id")
);

-- Creating an Genre Table
CREATE TABLE "genre" (
  "id" serial integer,
  "name" varchar(255),
  PRIMARY KEY ("id")
);

CREATE TABLE "music_album_genres" (
  "music_album_id" integer,
  "genre_id" integer,
  CONSTRAINT "FK_music_album_genres.music_album_id"
    FOREIGN KEY ("music_album_id")
      REFERENCES "music_albums"("id"),
  CONSTRAINT "FK_music_album_genres.genre_id"
    FOREIGN KEY ("genre_id")
      REFERENCES "Genre"("id")
);



