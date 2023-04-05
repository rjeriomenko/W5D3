require_relative "boarddbconnection.rb"
require_relative "user"
require_relative "reply"
require_relative "question_follow"

class Question
    attr_accessor :title, :user_id, :body
    attr_reader :id
    
    def self.all
        data = BoardDBConnection.instance.execute(<<-SQL)
            SELECT * FROM questions;
        SQL
        data.map {|datum| Question.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @user_id = options['user_id']
    end
    
    def self.find_by_id(id)
        self.all[id + -1]
    end

    def self.find_by_author_id(author_id)
        data = BoardDBConnection.instance.execute(<<-SQL, author_id)
        SELECT
            *
        FROM
            questions
        WHERE
            user_id = ?
        SQL

        data.map {|datum| Question.new(datum)}
    end

    def author
        data = BoardDBConnection.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?
        SQL
        data.map {|datum| User.new(datum)}
    end

    def replies
        Reply.find_by_question_id(id)
    end   

    def followers
        QuestionFollow.followers_for_question_id(id)
    end 
        
end