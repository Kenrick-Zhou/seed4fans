json.array!(@movie_tags) do |movie_tag|
  json.extract! movie_tag, :id, :movie_id, :tag_id, :name
  json.url movie_tag_url(movie_tag, format: :json)
end
