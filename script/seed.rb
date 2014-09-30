require 'rest_client'
require 'csv'
require 'colorize'

puts "Script is running...".colorize(:blue)

host = ARGV.first || "localhost:3000"
file = 'data/seed_data.csv'


  if File.exists?(file)
    puts "SCV file exists".colorize(:green)
    CSV.foreach(file, headers: true)  do |row|
      begin
        RestClient.get(host + '/update', :params => {:temp => row['temp'], :hum => row['hum']})
      rescue Errno::ECONNREFUSED => msg
        puts (msg.to_s + ". No connection to the server.").colorize(:red)
        break
      end
      puts "Successfully sent data!".colorize(:green)
    end
  else
    puts "File not found".colorize(:red)
  end



