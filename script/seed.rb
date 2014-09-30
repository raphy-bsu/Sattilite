require 'rest_client'
require 'csv'
require 'colorize'

puts "Script is running...".colorize(:blue)

host = ARGV.first || "localhost:3000"
file = 'data/seed_data.csv'

begin
  if File.exists?(file)
    puts "SCV file exists".colorize(:green)
    CSV.foreach(file, headers: true)  do |row|
      RestClient.get(host + '/update', :params => {:temp => row['temp'], :hum => row['hum']})
      puts "Successfully sent data!".colorize(:green)
    end
  else
    puts "File not found".colorize(:red)
  end
rescue SystemCallError => msg
  puts (msg.to_s + ". Probably, try to start your local server").colorize(:red)
end


