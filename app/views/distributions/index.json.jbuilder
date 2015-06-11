json.array!(@distributions) do |distribution|
  json.extract! distribution, :id, :geography, :niche, :comments
  json.url distribution_url(distribution, format: :json)
end
