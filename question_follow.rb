# id INTEGER PRIMARY KEY,
# question_id INTEGER NOT NULL,
# user_id INTEGER NOT NULL,

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

end

p QuestionFollow.all
p QuestionFollow.find_by_id(1)