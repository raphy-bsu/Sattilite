module V1
  class Sensors < Grape::API
    include V1::Helpers::Defaults

    resource :sensors do
      desc 'Update sensor values'
      params do
        requires :password, type: String, desc: 'Password'
        requires :category_name, type: String, desc: 'Category name'
        requires :sensor_name, type: String, desc: 'Category name'
        requires :value, type: String, desc: 'Value'
        requires :time, type: Integer, desc: 'Value'
      end
      post '/' do
        password = 'abc'
        error!('401 Unauthorized', 401) unless params[:password] == password
        category = Category.where(abbr: params[:category_name]).first
        error!('404 Not found', 404) unless category
        sensor = category.sensors.where(abbr: params[:sensor_name]).first
        sensor.insert_value(params[:value], params[:time])
      end

      desc 'get sensors'
      get do
        Sensor.all
      end
    end

  end
end
