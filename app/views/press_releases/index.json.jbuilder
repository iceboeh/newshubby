json.array!(@press_releases) do |press_release|
  json.extract! press_release, :id, :title
  json.url press_release_url(press_release, format: :json)
end
