json.array!(@pressrelease_types) do |pressrelease_type|
  json.extract! pressrelease_type, :id, :name
  json.url pressrelease_type_url(pressrelease_type, format: :json)
end
