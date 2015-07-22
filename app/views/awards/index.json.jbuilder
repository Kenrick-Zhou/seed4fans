json.array!(@awards) do |award|
  json.extract! award, :id, :movie_id, :name, :sub
  json.url award_url(award, format: :json)
end
