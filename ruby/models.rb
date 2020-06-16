

require 'pg'
require 'active_record'
require 'composite_primary_keys'

ActiveRecord::Base.establish_connection(
	    :adapter => "postgresql",
	    :username => "codio",
	  # :password => "codio",
        :database => "bookratings")

# Book (books table in database)
#
# id : integer, primary key
# title: string
# author: string
#
class Book < ActiveRecord::Base

end

# User (users table in database)
#
# id : integer, primary key
# name: string
#
class User < ActiveRecord::Base

end

# Rating (ratings table in database)
#
# user_id: integer, FK users.id
# book_id: integer, FK books.id
# rating: integer (-5 to +5)
# primary key: user_id, book_id
#
class Rating < ActiveRecord::Base
   self.primary_keys = :user_id, :book_id

   # book_ratings gives us all the ratings for a book.
   # The hash maps from user_id to to that user's rating for this book.
   # If no such book_id exists, an empty hash is returned.
   # Example usage:
   #   user2rating = Rating.book_ratings 5
   def self.book_ratings book_id
      user2rating = Hash.new 
      Rating.where( book_id: book_id ).each do |r|
          user2rating[r.user_id] = r.rating
      end
      return user2rating
   end  
    
   # user_ratings returns a hash that shows a user's ratings.
   # The hash maps book_id to the user's rating.
   # If no such user_id exists, an empty hash is returned.
   # Example usage:
   #   book2rating = Rating.user_ratings 5
   def self.user_ratings user_id
      book2rating = Hash.new 
      Rating.where( user_id: user_id ).each do |r|
          book2rating[r.book_id] = r.rating
      end
      return book2rating
   end

   # book_ratings_array returns gives us all the ratings for a book,
   # and include ratings of zero for a user that did not read or rate 
   # the book.  Also, if no such user exists (for example, user_id=0
   # doesn't exist in the database), that non-user has a rating of zero.
   # If book_id does not exist in the db, an empty array is returned.
   #  
   # results = Rating.book_ratings_array(10) # gets ratings for book_id=10
   # results[5] # is user_id=5 rating of book_id = 10
   def self.book_ratings_array book_id
      user2rating = []
      Rating.where( book_id: book_id ).each do |r|
          user2rating[r.user_id] = r.rating
      end
      user2rating.map { |x| x ||= 0 }
   end  
    
   # user_ratings_array returns an array that shows all user's ratings
   # and a user has a zero if not read or rated the book.  Note: an
   # invalid book_id, i.e. a book that is not in the books table,
   # will be given a rating of zero.  For example, book_id = 0, cannot
   # exist.
   # If user_id does not exist in the db, an empty array is returned.
   #   
   # results = Rating.user_ratings_array(10) # gets ratings for user_id=10
   # results[5] # is the rating of book_id = 5 for user_id = 10
   def self.user_ratings_array user_id
      book2rating = [] 
      Rating.where( user_id: user_id ).each do |r|
          book2rating[r.book_id] = r.rating
      end
      book2rating.map { |x| x ||= 0 }
   end

end
