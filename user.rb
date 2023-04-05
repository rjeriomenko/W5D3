# id INTEGER PRIMARY KEY,
# fname TEXT NOT NULL,
# lname TEXT NOT NULL

require_relative "boarddbconnection.rb"
require_relative "question"
require_relative "reply"

class User
    attr_accessor :fname, :lname
    attr_reader :id

    def self.all
        data = BoardDBConnection.instance.execute(<<-SQL)
            SELECT * FROM users;
        SQL
        data.map {|datum| User.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
    
    def self.find_by_id(id)
        self.all[id + -1]
    end

    def self.find_by_name(fname, lname)
        data = BoardDBConnection.instance.execute(<<-SQL, fname, lname)
        SELECT
            *
        FROM
            users
        WHERE
            fname = ?
            AND lname = ?;
        SQL

        data.map {|datum| User.new(datum)}
    end

    def authored_questions
        Question.find_by_author_id(@id)
    end

    def authored_replies
        Reply.find_by_user_id(@id)
    end
end