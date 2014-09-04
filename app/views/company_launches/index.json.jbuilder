json.array!(@company_launches) do |company_launch|
  json.extract! company_launch, :id, :newsroom_id, :title
  json.url company_launch_url(company_launch, format: :json)
end
