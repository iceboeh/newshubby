class IntroductionController < ApplicationController
  include Wicked::Wizard
    
  steps :basic, :people, :what, :how, :clients, :businessmodel, :differentiation, :competitors, :problem, :funding, :logo
  

  def show
    @newsroom = current_newsroom
    
    case step
    
    when :basic
      @basic_step = true
    when :logo
      @finish_button = true
      
    end
    
    render_wizard
    
  end


  def finish_wizard_path
    newsroom_path(@newsroom)
  end  
  
  def update
    @newsroom = current_newsroom
    @company_launch = @newsroom.company_launches.last
    
    unless @newsroom.people.exists?
      @newsroom.people.create
    end
    
    unless @newsroom.fundings.exists?
      @newsroom.fundings.create
    end
    
    # Skip submit if no logo uploaded    
    #unless @logostep && params[:logo].present? == false
    
    @newsroom.update(newsroom_params)

    render_wizard @newsroom
  end
  
  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def newsroom_params
      params.require(:newsroom).permit(:company_name, :website, :press_phone, :press_email, :founded, :q_who_are_you, :q_what_you_do, :q_how_you_achieve, :q_clients, :logo, :location, :latitude, :longitude, :business_model, :differentiation, :competitors, :problem_solved, :twitter, :code, people_attributes: [:id, :name, :role, :presentation, :founder, :_destroy],  fundings_attributes: [:id, :investment_type, :name, :date, :amount, :_destroy], company_launches_attributes: [:id, :title, :quote, :link1, :link2, :file1, :file2, :file3, :embargo, :launch, :caption_file1, :caption_file2, :caption_file3, :caption_link1, :caption_link2, :interview_done, :_destroy], links_attributes: [:id, :link, :caption, :company_launch_id, :_destroy], uploads_attributes: [:id, :file, :caption, :company_launch_id, :_destroy])
    end
    
end
    
  
