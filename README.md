## Readme
Author: Mark D. Smucker

### bookratings database

This database comes from Michelle Craig and her "Personalized Book 
Recommendation System" homework 
( http://nifty.stanford.edu/2011/craig-book-recommendations/ ) and 
is used with the author's permission.  

The data comes from an earlier release that only had 32 users.  The data 
on the website now has 86 users (as of June 2020).

I have changed the names of the users.

### Two database versions

We can create the database using SQL DDL and DML to produce one version 
of the database.  

We can also create the database using ruby ActiveRecord, and this produces
a version more compatible with using ActiveRecord.

#### Creating the database in Postgresql with SQL

From the terminal:

```
sudo su postgres
psql
```
Then from within psql:
```
CREATE DATABASE bookratings ;
\q
```
Then `exit` the shell to get back to being user `codio`.  Verify you 
are `codio` with `whoami`.

We have already added user `codio` to the database, and so we can do the 
following to create tables and put data in them:

```
cd sql
psql -U codio -d bookratings
```
and then from within psql:
```
\i create-tables.sql
\i insert.sql
```
Do `\d` to see the tables.  Do a `select *` on tables as appropriate to 
verify data.

#### Creating the database in Postgresql with Ruby

First, `cd ruby` then run `bundle install` to make sure your environment 
is correct.

Then, to drop existing tables and create them fresh:
```
ruby reset-create.rb
```
Then to load data:
```
ruby load-data.rb
```
The `models.rb` file contains the ActiveRecord models.  

See `reset-create.rb` for the schema definition.

We have already added user `codio` to the database, and so we can 
use psql to invesitgate the DB: 
```
psql -U codio -d bookratings
```
Do `\d` to see the tables.  Do a `select *` on tables as appropriate 
to verify data.

From within psql, we see the schema:
```
bookratings=# \d
                List of relations
 Schema |         Name         |   Type   | Owner
--------+----------------------+----------+-------
 public | ar_internal_metadata | table    | codio
 public | books                | table    | codio
 public | books_id_seq         | sequence | codio
 public | ratings              | table    | codio
 public | users                | table    | codio
 public | users_id_seq         | sequence | codio
(6 rows)


bookratings=# \d books
                                 Table "public.books"
 Column |       Type        | Collation | Nullable |              Default
--------+-------------------+-----------+----------+-----------------------------------
 id     | bigint            |           | not null | nextval('books_id_seq'::regclass)
 title  | character varying |           | not null |
 author | character varying |           | not null |
Indexes:
    "books_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "ratings" CONSTRAINT "fk_rails_99afded93e" FOREIGN KEY (book_id) REFERENCES books(id)

bookratings=# \d users
                                 Table "public.users"
 Column |       Type        | Collation | Nullable |              Default
--------+-------------------+-----------+----------+-----------------------------------
 id     | bigint            |           | not null | nextval('users_id_seq'::regclass)
 name   | character varying |           | not null |
Indexes:
    "users_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "ratings" CONSTRAINT "fk_rails_a7dfeb9f5f" FOREIGN KEY (user_id) REFERENCES users(id)

bookratings=# \d ratings
               Table "public.ratings"
 Column  |  Type   | Collation | Nullable | Default
---------+---------+-----------+----------+---------
 rating  | integer |           | not null |
 user_id | bigint  |           | not null |
 book_id | bigint  |           | not null |
Indexes:
    "ratings_pkey" PRIMARY KEY, btree (user_id, book_id)
    "index_ratings_on_book_id" btree (book_id)
    "index_ratings_on_user_id" btree (user_id)
Foreign-key constraints:
    "fk_rails_99afded93e" FOREIGN KEY (book_id) REFERENCES books(id)
    "fk_rails_a7dfeb9f5f" FOREIGN KEY (user_id) REFERENCES users(id)

```