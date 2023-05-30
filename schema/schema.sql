CREATE TABLE "Label" (
  "id" bigserial,
  "title" varchar(150),
  "color" varchar(100),
  PRIMARY KEY ("id")
);

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

