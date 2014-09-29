require 'rest_client'
require 'csv'

  CSV.foreach('data/seed_data.csv', headers: true)  do |row|
     RestClient.get 'http://localhost:3000/update', :params => {:temp => row['temp'], :hum => row['hum']} 
  end  
