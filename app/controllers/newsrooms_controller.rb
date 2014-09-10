class NewsroomsController < ApplicationController
  before_action :set_newsroom, only: [:show, :edit, :update, :destroy]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:newsroom_update) { |u| 
      u.permit(:password, :password_confirmation, :current_password) 
    }
  end
  
  def terms_of_service
    
  end

  # GET /newsrooms
  # GET /newsrooms.json
  def index
    
    @index_body = true
    
    if current_newsroom.nil?
      @disable_header = true
    end
    
    unless params[:search].nil? || params[:search].strip.empty?
      @search = Sunspot.search Newsroom do
        fulltext params[:search]
      end
      @newsrooms = @search.results
    else 
      @newsrooms = Newsroom.all
    end
    
  end

  # GET /newsrooms/1
  # GET /newsrooms/1.json
  def show
    
    # Show exclusive press releases only to owner
    unless current_newsroom.nil?
      unless @newsroom.company_name == current_newsroom.company_name
        @company_launches = @newsroom.company_launches.where(exclusive: false).reverse
      else
        @company_launches = @newsroom.company_launches.all.reverse
      end
    end
    
  end

  # GET /newsrooms/new
  def new
    @newsroom = Newsroom.new
  end

  # GET /newsrooms/1/edit
  def edit
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
      if @newsroom.save
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
    respond_to do |format|
      if @newsroom.update(newsroom_params)
        format.html { redirect_to @newsroom, notice: 'Newsroom was successfully end.' }
        format.json { render :show, status: :ok, location: @newsroom }
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
      format.html { redirect_to newsrooms_url, notice: 'Newsroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsroom
      @newsroom = Newsroom.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsroom_params
      params.require(:newsroom).permit(:company_name, :website, :press_phone, :press_email, :founded, :q_who_are_you, :q_what_you_do, :q_how_you_achieve, :q_clients, :logo, :location, :competitors, :latitude, :longitude, :twitter, :problem_solved, :business_model, people_attributes: [:id, :name, :role, :presentation, :_destroy], fundings_attributes: [:id, :name, :amount, :investment_type, :date, :_destroy])
  end

end
