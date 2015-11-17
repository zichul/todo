json.array!(@lists) do |list|
  json.extract! list, :id, :title, :share_code, :user_id
  json.url list_url(list, format: :json)
end
