json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :cn_title, :original_title, :rating, :poster_url, :poster_id, :subtype, :pubyear, :duration, :imdb_id, :summary, :e_count, :e_duration
  json.url movie_url(movie, format: :json)
end
