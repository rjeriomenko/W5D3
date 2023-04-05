require_relative "boarddbconnection.rb"

class Reply
    attr_accessor :body, :question_id, :user_id, :reply_id
    attr_reader :id
    
    def self.all
        data = BoardDBConnection.instance.execute(<<-SQL)
            SELECT * FROM replies;
        SQL
        data.map {|datum| Reply.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @body = options['body']
        @user_id = options['user_id']
        @reply_id = options['reply_id']
    end
    
    def self.find_by_id(id)
        self.all[id + -1]
    end

end