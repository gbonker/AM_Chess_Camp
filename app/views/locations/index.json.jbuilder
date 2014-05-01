json.array!(@locations) do |location|
  json.extract! location, :location
end
