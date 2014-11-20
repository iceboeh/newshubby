ActiveAdmin.register PressRelease do

  controller do
    def scoped_collection
      PressRelease.includes(:newsroom)
    end
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
  
  index do
    column :title
    column :created_at
    column :update_at
    column :hex
    column :newsroom_id
    actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :specifics, :hex
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
