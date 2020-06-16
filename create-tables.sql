
CREATE TABLE books ( 
  id	integer PRIMARY KEY,
  title	VARCHAR(255) NOT NULL CHECK (title <> ''),
  author VARCHAR(50) NOT NULL CHECK (author <> '')
);

CREATE TABLE users ( 
  id	integer PRIMARY KEY,
  name	VARCHAR(50) NOT NULL CHECK (name <> '' )
) ;

CREATE TABLE ratings (
  user_id integer, 
  book_id integer,
  rating smallint NOT NULL,
  PRIMARY KEY (user_id, book_id),
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (book_id) REFERENCES books (id)
) ;
