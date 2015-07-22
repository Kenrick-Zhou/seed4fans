json.array!(@recommendations) do |recommendation|
  json.extract! recommendation, :id, :movie_id, :rcmd_id, :rcmd_name, :rcmd_poster_id, :rcmd_poster_cdn
  json.url recommendation_url(recommendation, format: :json)
end
