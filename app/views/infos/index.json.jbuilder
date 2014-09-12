json.set! :labels do
  json.array! @labels
end

json.set! :temps do
  json.array! @temps
end

json.set! :hums do
  json.array! @hums
end
