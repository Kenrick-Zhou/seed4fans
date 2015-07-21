json.array!(@movie_types) do |movie_type|
  json.extract! movie_type, :id, :movie_id, :type_id, :name
  json.url movie_type_url(movie_type, format: :json)
end
