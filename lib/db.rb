require 'pg'

class Db

  def initialize(args)
    @conn = conn = PG::Connection.open(args)
  end

  def query(args)
    results = @conn.exec("SELECT * FROM \"#{args[:table]}\";") # double quote table name as case sensitive!
  end

end


db = Db.new(:host => "localhost", :user => "postgres", :password => "root", :dbname => "property", :port => 5432)
result = db.query(table: 'RawAppData')
result.each do |row|
  puts row
  # row.each do |column|
  #  puts column
  # end
end
