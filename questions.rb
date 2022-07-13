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

    def self.all
        data = QConnection.instance.execute("SELECT * FROM users")
        data.map{|datum| Users.new(datum)} # this is an array 
    end 

    def self.find_by_id(id)
        id = QConnection.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE 
            id = ?
    SQL
    return nil if id.length == 0

    Users.new(id.first) #this is a hash 
    end 
      def self.find_by_name(fname,lname)
        name = QConnection.instance.execute(<<-SQL, fname,lname)
        SELECT
            *
        FROM
            users
        WHERE 
            fname = ? AND
            lname = ?
    SQL
    return nil if name.length == 0

    Users.new(name.first) #this is a hash 
    end 

    def initialize(hash)
        @id = hash['id']
        @fname = hash['fname']
        @lname = hash['lname']
    end 
   
    def authored_questions(id)
       question_misc = Question.find_by_user_id(id) #this is a hash
        
       return question_misc.select {|k,v| k == 'body'}
        
    end 


end 



class Question
    attr_accessor :user_id , :id, :body, :title

    def initialize(hash)
        @title = hash['title']
        @body = hash['body']
        @user_id = hash['user_id']
    end 

    def self.find_by_user_id(user_id)
     user_id = QConnection.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            questions
        WHERE 
            user_id = ?
    SQL
    return nil if user_id.length == 0

    Question.new(user_id.first) #this is a hash 

    end

end


class Reply

    attr_accessor :id, :user_id, :question_id, :body_reply

    def initialize(hash)
        @user_id = hash['user_id']
        @question_id = hash['question_id']
        @body_reply=hash['body_reply']
    end

    def self.find_by_user_id(user_id)
        user_id = QConnection.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE 
                user_id = ?
        SQL
        return nil if user_id.length == 0

        Reply.new(user_id.first) #this is a hash 

    end

 def self.find_by_question_id(question_id)
     question_id = QConnection.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            replies
        WHERE 
            question_id = ?
    SQL
    return nil if question_id.length == 0

    Reply.new(question_id.first) #this is a hash 
 end
 
end