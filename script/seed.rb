require 'rest_client'
require 'csv'

host = "localhost:3000"
file = 'data/seed_data.csv'

if File.exists?(file)
	CSV.foreach(file, headers: true)  do |row|
    RestClient.get(host + '/update', :params => {:temp => row['temp'], :hum => row['hum']})
  end
else
	puts "File not found"
end
