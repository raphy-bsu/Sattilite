json.array!(@payloads) do |payload|
  json.extract! payload, :id, :time, :temperature, :humidity
  json.url payload_url(payload, format: :json)
end
