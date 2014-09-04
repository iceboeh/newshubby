module NewsroomsHelper
  def resource_name
    :newsroom
  end
 
  def resource
    @resource ||= Newsroom.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:newsroom]
  end
end
