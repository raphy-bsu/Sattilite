json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :name, :category_id
  json.url sensor_url(sensor, format: :json)
end
