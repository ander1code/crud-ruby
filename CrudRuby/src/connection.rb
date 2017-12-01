require 'sqlite3'

class Connection

  def self.connect
    begin
      @db = SQLite3::Database.open "db.sqlite3"
      @db
    rescue SQLite3::Exception
      nil
    end
  end

end