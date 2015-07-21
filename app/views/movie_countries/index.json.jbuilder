json.array!(@movie_countries) do |movie_country|
  json.extract! movie_country, :id, :movie_id, :country_id, :name
  json.url movie_country_url(movie_country, format: :json)
end
