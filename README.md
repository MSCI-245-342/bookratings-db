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

### Creating the database in Postgresql

Note: This has already been done for MSCI 245 students.

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
Then `exit` the shell to get back to being user `codio`.  Verify you are `codio` with `whoami`.

We have already added user `codio` to the database, and so we can do the following to create
tables and put data in them:

```
psql -U codio -d bookratings
```
and then from within psql:
```
\i create-tables.sql
\i insert.sql
```
Do `\d` to see the tables.  Do a `select *` on tables as appropriate to verify data.




