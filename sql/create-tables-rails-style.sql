
CREATE TABLE books ( 
  id	SERIAL PRIMARY KEY,
  title	VARCHAR(255) NOT NULL CHECK (title <> ''),
  author VARCHAR(50) NOT NULL CHECK (author <> '')
);

CREATE TABLE users ( 
  id	SERIAL PRIMARY KEY,
  name	VARCHAR(50) NOT NULL CHECK (name <> '' )
) ;

CREATE TABLE ratings (
  id	SERIAL PRIMARY KEY,
  user_id integer NOT NULL, 
  book_id integer NOT NULL,
  rating smallint NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (book_id) REFERENCES books (id)
) ;

CREATE UNIQUE INDEX idx_ratings_user_book
ON ratings (user_id, book_id) ;

