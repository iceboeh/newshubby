json.array!(@people) do |person|
  json.extract! person, :id, :name, :role, :presentation, :newsroom_id
  json.url person_url(person, format: :json)
end
