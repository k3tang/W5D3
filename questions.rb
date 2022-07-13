require 'sqlite3'
require 'singleton'

class QConnection < SQLite3::Database
    include Singleton

        def initialize
            super('questions.db')
            self.type_translation = true
            self.results_as_hash = true
        end 
            
end

class Users

    attr_accessor :id, :fname, :lname

    # def self.all
    #     data = QConnection.instance.execute("SELECT * FROM users")
    #     data.map{|datum| Users.new(datum)} # this is an array 
    # end 

    def self.find_by_id(id)
        name = QConnection.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE 
            id = ?
    SQL
    return nil if name.length = 0

    Users.new(data.first) #this is a hash 
    end 

    def initialize(hash)
        @id = hash['id']
        @fname = hash['fname']
        @lname = hash['lname']
    end 



end 



