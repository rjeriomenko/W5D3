require "singleton"
require "sqlite3"

class BoardDBConnection < SQLite3::Database
    include Singleton

    def initialize()
        super('board.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end