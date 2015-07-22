json.array!(@hot_comments) do |hot_comment|
  json.extract! hot_comment, :id, :movie_id, :did, :name, :rating, :pubdate, :comment
  json.url hot_comment_url(hot_comment, format: :json)
end
