json.array!(@akas) do |aka|
  json.extract! aka, :id, :movie_id, :aka
  json.url aka_url(aka, format: :json)
end
