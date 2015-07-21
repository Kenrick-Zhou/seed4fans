json.array!(@movie_celebrities) do |movie_celebrity|
  json.extract! movie_celebrity, :id, :movie_id, :celebrity_id, :name, :role
  json.url movie_celebrity_url(movie_celebrity, format: :json)
end
