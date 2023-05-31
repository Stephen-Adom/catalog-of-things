CREATE TABLE "music_albums" (
  "id" serial integer,
  "item_id" integer,
  "on_spotify" boolean,
  "publish_date" datetime,
  PRIMARY KEY ("id")
);

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
