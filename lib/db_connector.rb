require 'mysql2'

class DbConnector

  def initialize(args)
    @host = args[:host]
    @user = args[:username]
    @pswd = args[:password]
    @port = args[:port]
    @db = args[:database]
    @client = Mysql2::Client.new(args)
  end

  def q(args)
    results = @client.query("SELECT #{args[:field]} from ApplicationData")
    #headers = results.fields # <= that's an array of field names, in order
    return results
  end

end


db = DbQuery.new(:host => "127.0.0.1", :username => "root", :password => "root", :database => "Property", :port => 8889)
results = db.q(:field => "appRef")
results.each(:as => :array) do |row| # as tells query in what form to deliver results - hash or array
  puts row
end
