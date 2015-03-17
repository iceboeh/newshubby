class NewsroomsController < ApplicationController
  before_action :set_newsroom, only: [:show, :edit, :update, :destroy]
  #before_action :set_pressrelease_type, only: [:show, :edit, :update, :destroy]
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate, only: [:allnewsrooms]
  
  autocomplete :press_release, :title

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:newsroom_update) { |u| 
      u.permit(:password, :password_confirmation, :current_password, :term_agreement) 
    }
  end

  def authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        username == ENV['HTACCESS_NAME'] && password == ENV['HTACCESS_PASSWORD']
      end
    end
  end
  
  def mailchimp
    @list_id = ENV["MAILCHIMP_LIST_ID"]
    gb = Gibbon::API.new

    gb.lists.subscribe({
      :id => @list_id,
      :email => {:email => params[:email][:address]},
      :double_optin => false
    })
        
    flash[:notice] = "Thanks for subscribing!"
    redirect_to root_path
    
  end
  
  def terms_of_service
    
  end
  
  def introduction
    @newsroom = current_newsroom
  end
  
  def allpressreleases
    @press_releases = PressRelease.includes(:uploads).all.order("press_releases.created_at DESC").where(exclusive: false).where.not(uploads: { file_file_name: nil }).where.not(title: nil).paginate(:page => params[:page], :per_page => 38)
  end

  def allnewsrooms
    @newsrooms = Newsroom.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 24)
    @newsroom_count = Newsroom.all.count
  end

  # GET /newsrooms
  # GET /newsrooms.json
  def index
    @transparentnavbar = true
    @index_body = true
    
    if params[:search]
     # @search = Sunspot.search Newsroom do
      #  fulltext params[:search]
      #end
      @press_releases = PressRelease.where(exclusive: false).where("embargo <= ?", Date.today).search(params[:search])
    else 
      @press_releases = PressRelease.includes(:uploads).all.order("press_releases.embargo DESC").where(exclusive: false).where("embargo <= ?", Date.today).where.not(uploads: { file_file_name: nil }).where.not(title: nil).paginate(:page => params[:page], :per_page => 4)
    end
    
  end

  # GET /newsrooms/1
  # GET /newsrooms/1.json
  def show
    @newsroom = Newsroom.friendly.find(params[:id])

    @nrBody = true

    # Control ownership
    if @newsroom == current_newsroom
      @owner = true
    else
      @owner = false
    end
    
    @introduction_failed = true if @newsroom.company_name.blank? || @newsroom.website.blank? || @newsroom.press_phone.blank? || @newsroom.founded.blank? || @newsroom.q_what_you_do.blank? || @newsroom.q_how_you_achieve.blank? || @newsroom.q_clients.blank? || @newsroom.business_model.blank? || @newsroom.competitors.blank? || @newsroom.differentiation.blank? || @newsroom.problem_solved.blank?
    
    # Payment code check
    #@code = @newsroom.code
    #@code_match = Code.find_by_code(@code)
    
    #if @newsroom.subscription.nil?
    #  unless @code_match.nil?
    #    duration = "#{@code_match.duration}.months"
    #    @newsroom.create_subscription(plan_id: 1, email: @newsroom.email, end: Time.now + eval(duration))     # create subscription with end time X months after signup
    #    @code_match.destroy      # retire code
    #  else
    #    flash[:error] = "Invalid signup code. Try again."
    #    redirect_to plans_path
    #  end
    #end

    # Show exclusive press releases only to owner
    if @owner
      @press_releases = @newsroom.press_releases.order("embargo DESC").paginate(:page => params[:page], :per_page => 3)
    else
      @press_releases = @newsroom.press_releases.where(exclusive: false).where("embargo <= ?", Date.today).order("embargo DESC").paginate(:page => params[:page], :per_page => 3)
    end
    
  end

  # GET /newsrooms/new
  def new
    @newsroom = Newsroom.new
  end

  # GET /newsrooms/1/edit
  def edit
    @newsroom = Newsroom.friendly.find(params[:id])
    
    @nrBody = true
    
    # Control ownership
    if @newsroom != current_newsroom
      @owner = false
    else
      @owner = true
    end
    
    # Handle ownership
    unless @owner
      flash[:notice] = "Not your newsroom. Hands off!"
      redirect_to :root
    end
    
    @newsroom = current_newsroom
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Not yours to edit!"
    redirect_to :root
  end

  # POST /newsrooms
  # POST /newsrooms.json
  def create
    @newsroom = Newsroom.new(newsroom_params)

    respond_to do |format|
      if @newsroom.save.valid?
        format.html { redirect_to @newsroom, notice: 'Newsroom was successfully created.' }
        format.json { render :show, status: :created, location: @newsroom }
      else
        format.html { render :new }
        format.json { render json: @newsroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsrooms/1
  # PATCH/PUT /newsrooms/1.json
  def update
    @newsroom = current_newsroom
    
    respond_to do |format|
      
      # Remove duplicate people
      @newsroom.people.select(:name,:role).group(:name,:role).having("count(*) > 1").each do |x|
        @newsroom.people.where(name: x.name, role: x.role).destroy_all
      end
      
      # Remove duplicate funding
      @newsroom.fundings.select(:name,:amount).group(:name,:amount).having("count(*) > 1").each do |x|
        @newsroom.fundings.where(name: x.name, amount: x.amount).destroy_all
      end
      
      # Correct website URL
      
      unless params[:newsroom][:website].start_with?("http://")
        params[:newsroom][:website] = "http://"+params[:newsroom][:website]
      end
      

      
     # unless @newsroom.code.blank? && @newsroom.update(newsroom_params)
      #  format.html { redirect_to plans_path, notice: 'Beta Code Accepted' }
       # format.json { render :update }
        #format.js { render "press_releases/update", notice: "Saved!" }
    #  else
     #   format.html { render :edit }
      #  format.json { render json: @newsroom.errors, status: :unprocessable_entity }
      #end
      
      if @newsroom.update(newsroom_params)
        
        format.html { redirect_to @newsroom, notice: 'Newsroom was successfully updated.' }
        format.json { render :update }
        format.js { render "newsrooms/update", notice: "Saved!", newsroom: @newsroom }
      else
        format.html { render :edit }
        format.json { render json: @newsroom.errors, status: :unprocessable_entity }
      end
      
    end
  end

  # DELETE /newsrooms/1
  # DELETE /newsrooms/1.json
  def destroy
    @newsroom = current_newsroom
    @newsroom.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Newsroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsroom
      
      @newsrooms = Newsroom.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsroom_params
      params.require(:newsroom).permit(:company_name, :differentiation, :website, :press_phone, :term_agreement, :press_email, :founded, :q_who_are_you, :q_what_you_do, :q_how_you_achieve, :q_clients, :logo, :location, :competitors, :latitude, :longitude, :twitter, :problem_solved, :business_model, people_attributes: [:id, :name, :role, :presentation, :founder, :_destroy], fundings_attributes: [:id, :name, :amount, :investment_type, :date, :_destroy])
  end

end
