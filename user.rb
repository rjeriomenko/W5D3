require_relative "boarddbconnection.rb"

class User
    def self.all
        BoardDBConnection.instance.execute(<<-SQL)
            SELECT * FROM users;
        SQL
    end


end
