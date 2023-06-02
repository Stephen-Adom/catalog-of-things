
-- Creating an Label Table

CREATE TABLE "Label" (
  "id" bigserial,
  "title" varchar(255),
  "color" varchar(100),
  PRIMARY KEY ("id")
);

-- Creating an Genre Table

CREATE TABLE "Genre" (
  "id" bigserial,
  "name" varchar(255),
  PRIMARY KEY ("id")
);

-- Creating an Author Table

CREATE TABLE "Author" (
  "id" bigserial,
  "first_name" varchar(255),
  "last_name" varchar(255),
  PRIMARY KEY ("id")
);

-- Creating an Book Table

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
      REFERENCES "Label"("id"),
  CONSTRAINT "FK_Book.genre_id"
    FOREIGN KEY ("genre_id")
      REFERENCES "Genre"("id"),
  CONSTRAINT "FK_Book.author_id"
    FOREIGN KEY ("author_id")
      REFERENCES "Author"("id")
);

-- Creating a Game Table
CREATE TABLE "Game" (
  "id" bigserial,
  "genre_id" int,
  "author_id" int,
  "label_id" int,
  "multiplayer" bool,
  "last_played_at" date,
  "publish_date" date,
  "archived" bool,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_Game.author_id"
    FOREIGN KEY ("author_id")
      REFERENCES "Author"("id"),
  CONSTRAINT "FK_Game.label_id"
    FOREIGN KEY ("label_id")
      REFERENCES "Label"("id"),
  CONSTRAINT "FK_Game.genre_id"
    FOREIGN KEY ("genre_id")
      REFERENCES "Genre"("id")
);

-- Creating an music albums Table
CREATE TABLE "MusicAlbum" (
  "id" bigserial,
  "genre_id" int,
  "author_id" int,
  "label_id" int,
  "on_spotify" bool,
  "publish_date" date,
  "archived" bool,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_MusicAlbum.label_id"
    FOREIGN KEY ("label_id")
      REFERENCES "Label"("id"),
  CONSTRAINT "FK_MusicAlbum.author_id"
    FOREIGN KEY ("author_id")
      REFERENCES "Author"("id"),
  CONSTRAINT "FK_MusicAlbum.genre_id"
    FOREIGN KEY ("genre_id")
      REFERENCES "Genre"("id")
);
