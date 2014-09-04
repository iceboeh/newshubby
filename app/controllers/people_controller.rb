class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @people = @newsroom.people.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
  end

  # GET /people/new
  def new
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @person = current_newsroom.people.friendly.find(params[:id])    
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Not yours to edit!"
    redirect_to :root
  end

  # POST /people
  # POST /people.json
  def create
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @person = @newsroom.people.create(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to [@person.newsroom, @person], notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to [@person.newsroom, @person], notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @people = current_newsroom.people.friendly.find(params[:id])
    @person.destroy
    respond_to do |format|
      format.html { redirect_to newsroom_people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :role, :presentation, :newsroom_id)
    end
end
