class CompanyLaunchesController < ApplicationController
  before_action :set_company_launch, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_newsroom!, except: [:index, :show]
  
  # GET /company_launches
  # GET /company_launches.json
  def index
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    
    # Show exclusive press releases only to owner
    
    unless @newsroom == current_newsroom
      @company_launches = @newsroom.company_launches.where(exclusive: false).reverse
    else
      @company_launches = @newsroom.company_launches.all.reverse
    end
    
  end

  def type
    @about_body = true
  end

  # GET /company_launches/1
  # GET /company_launches/1.json
  def show
    
    @no_body = true
    @pr_body = true
    
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @company_launch = @newsroom.company_launches.friendly.find(params[:id])    
    
    if @blocked == true
      redirect_to :root
    end
    
    # Not paid
    # Disable header
    @disable_header == true
    
    # Control ownership
    if @newsroom != current_newsroom
      @owner = false
    else
      @owner = true
    end
    
  end
  
  # GET /company_launches/new
  def new
    
    @no_body = true
    @pr_body = true
       
     
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
     hex = SecureRandom.urlsafe_base64(6)
    
     # Subscription ended?
     if @newsroom.subscription.end < Time.now
       redirect_to plans_path
     else
     
    @company_launch = current_newsroom.company_launches.new(q_what_you_do: @newsroom.q_what_you_do, q_how_you_achieve: @newsroom.q_how_you_achieve, q_clients: @newsroom.q_clients, differentiation: @newsroom.differentiation, problem_solved: @newsroom.problem_solved, business_model: @newsroom.business_model, competitors: @newsroom.competitors, hex: hex, interview_done: true, company_name: @newsroom.company_name, website: @newsroom.website, press_phone: @newsroom.press_phone, press_email: @newsroom.press_email, founded: @newsroom.founded)
    end
    
  end
  
  # GET /company_launches/1/edit
  def edit
    
    @newsroom = @company_launch.newsroom
    
    # Control ownership
    if @newsroom.company_launches.friendly.find(params[:id]) != current_newsroom.company_launches.friendly.find(params[:id])
      @owner = false
    else
      @owner = true
    end
    
    unless @owner
      flash[:notice] = "Not your press release. Hands off!"
      redirect_to :root
    end
    
    @newsroom = current_newsroom
    @company_launches = current_newsroom.company_launches.friendly.find(params[:id])    
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Not yours to edit!"
    redirect_to :root
  end

  # POST /company_launches
  # POST /company_launches.json
  def create
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @company_launch = @newsroom.company_launches.create(company_launch_params)
    
    respond_to do |format|
      if @company_launch.save
        format.html { redirect_to [@company_launch.newsroom, @company_launch], notice: 'Press release was successfully created.' }
        format.json { render :show, status: :created, location: @company_launch }
      else
        format.html { render :new }
        format.json { render json: @company_launch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_launches/1
  # PATCH/PUT /company_launches/1.json
  def update
    
    respond_to do |format|
      if @company_launch.update(company_launch_params)
        format.html { redirect_to [@company_launch.newsroom, @company_launch], notice: 'Press release was successfully updated.' }
        format.json { render :show, status: :ok, location: @company_launch }
      else
        format.html { render :edit }
        format.json { render json: @company_launch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_launches/1
  # DELETE /company_launches/1.json
  def destroy
    @company_launches = current_newsroom.company_launches.friendly.find(params[:id])
    @company_launch.destroy
    respond_to do |format|
      format.html { redirect_to edit_newsroom_path(current_newsroom), notice: 'Press release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_launch
      @company_launch = CompanyLaunch.friendly.find(params[:id])
      
      @no_body = true
      @pr_body = true
      
      # Block exclusive press releases for everyone but owner and hex
      unless @company_launch.exclusive == false || @company_launch.hex == params[:hex] || @company_launch.exclusive == true && current_newsroom.company_name == @company_launch.newsroom.company_name
        @blocked = true
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_launch_params
      params.require(:company_launch).permit(:title, :newsroom_id, :exclusive, :hex, :quote, :link1, :link2, :file1, :file2, :file3, :embargo, :launch, :caption_file1, :caption_file2, :caption_file3, :caption_link1, :caption_link2, :text, :interview_done, :_destroy, :business_model, :problem_solved, :competitors, newsroom_attributes: [:company_name, :website, :press_email, :press_phone], link_attributes: [:caption, :link, ])
    end
end