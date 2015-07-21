json.array!(@celebrities) do |celebrity|
  json.extract! celebrity, :id, :name
  json.url celebrity_url(celebrity, format: :json)
end
