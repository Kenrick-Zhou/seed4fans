json.array!(@doulists) do |doulist|
  json.extract! doulist, :id, :movie_id, :name, :dlist_id, :uname
  json.url doulist_url(doulist, format: :json)
end
