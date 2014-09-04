json.array!(@newsrooms) do |newsroom|
  json.extract! newsroom, :id, :company_name, :website, :press_phone, :press_email, :founded, :q_who_are_you, :q_what_you_do, :q_how_you_achieve, :q_clients
  json.url newsroom_url(newsroom, format: :json)
end
