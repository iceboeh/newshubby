ActiveAdmin.register Newsroom do

  controller do
    def scoped_collection
      Newsroom.includes(:press_releases)
    end
    
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
  
  index do
    column :company_name
    column :email
    column :code
    actions
  end
  
 

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :company_name, :website, :press_phone, :term_agreement, :press_email, :founded, :q_who_are_you, :q_what_you_do, :q_how_you_achieve, :q_clients, :logo, :location, :competitors, :latitude, :longitude, :twitter, :problem_solved, :business_model, people_attributes: [:id, :name, :role, :presentation, :founder, :_destroy], fundings_attributes: [:id, :name, :amount, :investment_type, :date, :_destroy]
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
