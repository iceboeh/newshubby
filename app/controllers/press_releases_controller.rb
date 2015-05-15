class PressReleasesController < ApplicationController
  before_action :set_press_release, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  load_and_authorize_resource :newsroom
  load_and_authorize_resource :press_release, :through => :newsroom
  

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
      @press_releases = @newsroom.press_releases.all.order("embargo DESC").paginate(:page => params[:page], :per_page => 8)
    else
      @press_releases = @newsroom.press_releases.all.where(exclusive: false).where('embargo <= ?', Date.today).order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
    end
  end

  # GET /press_releases/1
  # GET /press_releases/1.json
  def show
    
    # When we change Title for a Press Release, we must be redirected correctly
    if request.path != newsroom_press_release_path(@newsroom, @press_release)
      redirect_to [@newsroom, @press_release], status: :moved_permanently
    end
    
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
    
    if current_newsroom.nil?
      redirect_to root_path, notice: 'You need to sign in or sign up to create press releases.'
    else
    
    @newsroom = current_newsroom
    @press_releases = PressRelease.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
    @press_release = @newsroom.press_releases.last
    
    @press_release_types = PressreleaseType.all.where.not(name: "Manual")
    @manual = PressreleaseType.all.where(name: "Manual").first
    
    @introduction_failed = true if @newsroom.company_name.blank? || @newsroom.website.blank? || @newsroom.founded.blank? || @newsroom.q_what_you_do.blank? || @newsroom.q_how_you_achieve.blank?
    if @introduction_failed == true
      flash[:notice] = "Finish the introductory questions first, please!"
      redirect_to introduction_index_path
    end
    
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
        @press_release.uploads.build
        @press_release.links.build
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
    @disable_footer = true
    @reg_body = true
    @newsroom = @press_release.newsroom
    @press_release = @newsroom.press_releases.friendly.find(params[:id])
    
    # Check required fields and make array
    @required_fields = @press_release.pressrelease_type.required_fields.split(",") unless @press_release.pressrelease_type.required_fields.nil?
    # Sätt inte count här, utan på opopulerade fält
    @required_fields_count = @required_fields.count unless @required_fields.nil?
    
    # Check which fields are populated/unpopulated
    @newsroom_fields = ["q_who_are_you", "q_what_you_do", "q_how_you_achieve", "q_clients", "business_model", "competitors", "differentiation", "problem_solved", "people", "fundings"] # These are all the Newsroom qustions
    
    # IF WE NEED TO ADD "people", "funding", etc we have to do a smarter check below. Check @newsroom.fundings and @newsroom.people instead of @newsroom[people] because it's not a field

    # Make array for unpopulated fields
    @blank_fields = Array.new
    
    # Check which fields are populated/unpopulated
    unless @required_fields.nil?
      @required_fields.each do |field|
        if @newsroom_fields.include? field
          command = "@newsroom." + field.to_s
          @blank_fields << field.to_s if eval(command).blank?
        end
      end
    end
    
    # Count unpopulated fields (array.count)
    @blank_fields_count = @blank_fields.count

    
    # Each unpopulated field should get a NUMBER so we know which one it is. 
    # Do this in the view. Set and show correct <div>
    
    # Display questions for unpopulated fields
    # Do this in the view, show the correct ones
    # Set correct number for modals, divs, etc
    # Correct for this in the general view too, for each
    
    # Display correct divs, modals, examples, tips, etc for unpopulated fields (and all other fields)
    
    
    
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
          @press_release.links.where(caption: x.caption, link: x.link).offset(1).destroy_all
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
      format.html { redirect_to :back, notice: 'Press release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def distribution
    @press_release = PressRelease.friendly.find(params[:id])
    @newsroom = @press_release.newsroom
    ContactMailer.distribution_mail(@press_release).deliver
    ContactMailer.distribution_client_confirmation(@press_release).deliver
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
