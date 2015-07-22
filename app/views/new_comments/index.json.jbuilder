json.array!(@new_comments) do |new_comment|
  json.extract! new_comment, :id, :movie_id, :did, :name, :rating, :pubdate, :comment
  json.url new_comment_url(new_comment, format: :json)
end
