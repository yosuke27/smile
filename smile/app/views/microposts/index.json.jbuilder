json.array!(@microposts) do |micropost|
  json.extract! micropost, :id, :datecode, :user_id, :content, :mood, :is_onechance
  json.url micropost_url(micropost, format: :json)
end
