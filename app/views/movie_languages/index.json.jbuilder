json.array!(@movie_languages) do |movie_language|
  json.extract! movie_language, :id, :movie_id, :language_id, :name
  json.url movie_language_url(movie_language, format: :json)
end
