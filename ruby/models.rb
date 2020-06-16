

require 'pg'
require 'active_record'

ActiveRecord::Base.establish_connection(
	    :adapter => "postgresql",
	    :username => "codio",
	  # :password => "codio",
        :database => "bookratings")
		
class Book < ActiveRecord::Base

end

class User < ActiveRecord::Base

end

class Rating < ActiveRecord::Base

end
