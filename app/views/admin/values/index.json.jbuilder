json.array!(@values) do |value|
  json.extract! value, :id, :type, :val_float, :val_int, :val_str, :val_bool, :sensor_id
  json.url value_url(value, format: :json)
end
