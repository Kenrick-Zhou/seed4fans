json.array!(@photos) do |photo|
  json.extract! photo, :id, :movie_id, :pid, :cdn
  json.url photo_url(photo, format: :json)
end
