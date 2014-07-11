json.array!(@places) do |place|
  json.extract! place, :id, :name, :description, :neighborhood, :rating
  json.url place_url(place, format: :json)
end
