json.array!(@tweets) do |tweet|
  json.id tweet.id
  json.message tweet.message
  json.created_at tweet.created_at
  json.user_username tweet.user.username
end
