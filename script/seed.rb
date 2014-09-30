require 'rest_client'
require 'csv'
require 'colorize'

puts "Script is running...".blue

host = ARGV.first || "localhost:3000"
file = 'data/seed_data.csv'


  if File.exists?(file)
    puts "SCV file exists".green
    CSV.foreach(file, headers: true)  do |row|
      begin
        RestClient.get(host + '/update', :params => {:temp => row['temp'], :hum => row['hum']})
      rescue Errno::ECONNREFUSED => msg
        puts (msg.to_s + ". No connection to the server.").red
        break
      end
    end
    puts "Successfully sent data!".green
  else
    puts "File not found".red
  end



