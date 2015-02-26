class PressReleasesController < ApplicationController
  before_action :set_press_release, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js


  # GET /press_releases
  # GET /press_releases.json
  def index
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    
    # Control ownership
    if @newsroom == current_newsroom
      @owner = true
    else
      @owner = false
    end

    # Show exclusive press releases only to owner
    if @owner == true
      @press_releases = @newsroom.press_releases.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
    else
      @press_releases = @newsroom.press_releases.all.where(exclusive: false).order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
    end
  end

  # GET /press_releases/1
  # GET /press_releases/1.json
  def show
        
    if @blocked
      flash[:notice] = "No such press release!"
      redirect_to :root
    end
    
    # Control ownership
    if @press_release.newsroom == current_newsroom
      @owner = true
    else
      @owner = false
    end
  end

  def select
    @newsroom = current_newsroom
    @press_releases = PressRelease.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
    @press_release = @newsroom.press_releases.last
    
    @introduction_failed = true if @newsroom.company_name.blank? || @newsroom.website.blank? || @newsroom.press_phone.blank? || @newsroom.founded.blank? || @newsroom.q_what_you_do.blank? || @newsroom.q_how_you_achieve.blank? || @newsroom.q_clients.blank? || @newsroom.business_model.blank? || @newsroom.competitors.blank? || @newsroom.differentiation.blank? || @newsroom.problem_solved.blank?
    if @introduction_failed == true
      flash[:notice] = "Finish the introductory questions first, please!"
      redirect_to introduction_index_path
    end
    
  end


  # GET /press_releases/new
  def new    
    @newsroom = current_newsroom
    @press_release = @newsroom.press_releases.new(pressrelease_type_id: params[:pressrelease_type_id])
    
    #if @newsroom.subscription.nil?
    #  flash[:notice] = "You can't create a press release without a subscription!"
    #  redirect_to plans_path
    #else
      unless @newsroom.company_name.blank?
        @press_release.links.build
        @press_release.uploads.build
        @press_release.hex = SecureRandom.urlsafe_base64(6)
        if @press_release.newsroom.people.last.nil?
          @press_release.newsroom.people.build
        end
        if @press_release.newsroom.fundings.last.nil?
          @press_release.newsroom.fundings.build
        end
        @press_release.save
        redirect_to edit_newsroom_press_release_path(@press_release.newsroom, @press_release)
      end
      #end
  end

  # GET /press_releases/1/edit
  def edit
    @reg_body = true
    @newsroom = @press_release.newsroom
    @press_release = @newsroom.press_releases.friendly.find(params[:id])
    
    if @newsroom.business_model.blank?
      @nr_questions = true
    end
    
    #if @newsroom.subscription.nil?
    #  flash[:notice] = "You can't create a press release without a subscription!"
    #  redirect_to plans_path
    #end
    
    # Control ownership
    if @newsroom.press_releases.friendly.find(params[:id]) != current_newsroom.press_releases.friendly.find(params[:id])
      @owner = false
    else
      @owner = true
    end
    
    unless @owner
      flash[:notice] = "Not your press release. Hands off!"
      redirect_to :root
    end
    
    @newsroom = current_newsroom
    @press_releases = current_newsroom.press_releases.friendly.find(params[:id])    
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Not yours to edit. Hands off!"
    redirect_to :root
    
  end

  # POST /press_releases
  # POST /press_releases.json
  def create
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @press_release = @newsroom.press_releases.new(press_release_params)
    @press_release.hex = SecureRandom.urlsafe_base64(6)
    #redirect_to edit_newsroom_press_release_path(@press_release.newsroom, @press_release)

    respond_to do |format|
      if @press_release.save
        format.html { redirect_to edit_newsroom_press_release_path(@press_release.newsroom, @press_release), notice: 'Press release was successfully created.' }
        format.json { render :show, status: :created, location: @press_release }
        format.js { redirect_to edit_newsroom_press_release_path(@press_release.newsroom, @press_release) }
      else
        format.html { render :new }
        format.json { render json: @press_release.errors, status: :unprocessable_entitity }
      end
    end
  end

  # PATCH/PUT /press_releases/1
  # PATCH/PUT /press_releases/1.json
  def update
    
    # Control ownership
    if @newsroom.press_releases.friendly.find(params[:id]) != current_newsroom.press_releases.friendly.find(params[:id])
      @owner = false
    else
      @owner = true
    end
    
    unless @owner
      flash[:notice] = "Not your press release. Hands off!"
      redirect_to :root
    end
    
    respond_to do |format|
      if @press_release.update(press_release_params)
      
      # TRY TO SAVE DATES MORE HANDSOMELY
      #  if params[:specifics["launch_date(1i)"]]
      #    params[:specifics["launch_date(1i)"]] = params[:specifics["launch_date(1i)"]]+params[:specifics["launch_date(1i)"]]+params[:specifics["launch_date(1i)"]]
      #  end
        
        # Remove duplicates
        @press_release.links.select(:caption,:link).group(:caption,:link).having("count(*) > 1").each do |x|
          @press_release.links.where(caption: x.caption, link: x.link).destroy_all
        end
        
        format.html { redirect_to edit_newsroom_press_release_path(@press_release.newsroom, @press_release), notice: 'Press Release was successfully updated.' }
        format.json { respond_with_bip(@press_release) }
        format.js { render "press_releases/update", notice: "Saved!" }
      else
        format.html { render :edit }
        format.json { render json: @press_release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /press_releases/1
  # DELETE /press_releases/1.json
  def destroy
    @press_release.destroy
    respond_to do |format|
      format.html { redirect_to edit_newsroom_path(current_newsroom), notice: 'Press release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def distribution
    @press_release = PressRelease.friendly.find(params[:id])
    @newsroom = @press_release.newsroom
    ContactMailer.distribution_mail(@press_release).deliver
    redirect_to @newsroom, notice: "We love that you want us to distribute your press release. We'll get back to you within 24 hours with details about how we'll do this"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_press_release
      @newsroom = Newsroom.friendly.find(params[:newsroom_id])
      @press_release = @newsroom.press_releases.friendly.find(params[:id])
      
      # Block exclusive press releases for everyone but owner and hex
      if @press_release.exclusive? && @press_release.hex != params[:hex] && current_newsroom != @press_release.newsroom
        @blocked = true
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def press_release_params
      params.require(:press_release).permit!
    end
end
