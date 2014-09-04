json.array!(@fundings) do |funding|
  json.extract! funding, :id, :investment_type, :name, :date, :amount, :newsroom_id
  json.url funding_url(funding, format: :json)
end
