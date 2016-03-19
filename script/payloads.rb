require 'rest_client'
require 'csv'
require 'colorize'

puts "Script is running...".blue

host = ARGV.first || "localhost:3000"
file = 'data/payloads.csv'

if File.exists?(file)
  puts "SCV file exists".green
  CSV.foreach(file, col_sep: ';',  headers: true)  do |row|
    sleep 1
    begin
      RestClient.post(host + '/payloads.json', payload: {:time => row['Time'],
                                                         :temperature => row['Temperature'],
                                                         :humidity => row['Humidity']})
    rescue Errno::ECONNREFUSED => msg
      puts (msg.to_s + ". No connection to the server.").red
      break
    end
  end
  puts "Successfully sent data!".green
else
  puts "File not found".red
end


