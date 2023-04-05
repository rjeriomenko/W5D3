# id INTEGER PRIMARY KEY,
# question_id INTEGER NOT NULL,
# user_id INTEGER NOT NULL,
require_relative "user.rb"
require_relative "question"
require_relative "boarddbconnection.rb"

class QuestionFollow
    attr_accessor :question_id, :user_id
    attr_reader :id
    
    def self.all
        data = BoardDBConnection.instance.execute(<<-SQL)
            SELECT * FROM question_follows;
        SQL
        data.map { |datum| QuestionFollow.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
    
    def self.find_by_id(id)
        self.all[id + -1]
    end

    def self.followers_for_question_id(question_id)
        data = BoardDBConnection.instance.execute(<<-SQL, question_id)
            SELECT 
                users.id, fname, lname 
            FROM 
                users   
                JOIN
                    question_follows ON question_follows.user_id = users.id
            WHERE
                question_id = ?;
        SQL
        data.map { |datum| User.new(datum) }
    end

    def self.followed_questions_for_user_id(user_id)
        data = BoardDBConnection.instance.execute(<<-SQL, user_id)
            SELECT 
                title, body, questions.user_id, questions.id
            FROM 
                questions   
                JOIN
                    question_follows ON question_follows.question_id = questions.id
            WHERE
                question_follows.user_id = ?;
        SQL
        data.map { |datum| Question.new(datum) }
    end

end