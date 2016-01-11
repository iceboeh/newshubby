class PressreleaseTypesController < ApplicationController
  #http_basic_authenticate_with name: ENV['HTACCESS_NAME'], password: ENV['HTACCESS_PASSWORD'] if Rails.env.production?

  load_and_authorize_resource :newsroom
  #load_and_authorize_resource :pressrelease_type

  before_action :set_pressrelease_type, only: [:show, :edit, :update, :destroy]

  # GET /pressrelease_types
  # GET /pressrelease_types.json
  def index
    @pressrelease_types = PressreleaseType.all
  end

  # GET /pressrelease_types/1
  # GET /pressrelease_types/1.json
  def show
  end

  # GET /pressrelease_types/new
  def new
    @pressrelease_type = PressreleaseType.new
  end

  # GET /pressrelease_types/1/edit
  def edit
  end

  # POST /pressrelease_types
  # POST /pressrelease_types.json
  def create
    @pressrelease_type = PressreleaseType.new(pressrelease_type_params)

    respond_to do |format|
      if @pressrelease_type.save
        format.html { redirect_to @pressrelease_type, notice: 'Pressrelease type was successfully created.' }
        format.json { render :show, status: :created, location: @pressrelease_type }
      else
        format.html { render :new }
        format.json { render json: @pressrelease_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pressrelease_types/1
  # PATCH/PUT /pressrelease_types/1.json
  def update
    respond_to do |format|
      if @pressrelease_type.update(pressrelease_type_params)
        format.html { redirect_to @pressrelease_type, notice: 'Pressrelease type was successfully updated.' }
        format.json { render :show, status: :ok, location: @pressrelease_type }
      else
        format.html { render :edit }
        format.json { render json: @pressrelease_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pressrelease_types/1
  # DELETE /pressrelease_types/1.json
  def destroy
    @pressrelease_type.destroy
    respond_to do |format|
      format.html { redirect_to pressrelease_types_url, notice: 'Pressrelease type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pressrelease_type
      @pressrelease_type = PressreleaseType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pressrelease_type_params
      params.require(:pressrelease_type).permit!
    end
end
