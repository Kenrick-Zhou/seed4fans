json.array!(@dusers) do |duser|
  json.extract! duser, :id, :uid, :name, :c_follower, :c_m_do, :c_m_wish, :c_m_collect, :c_doulist, :error
  json.url duser_url(duser, format: :json)
end
