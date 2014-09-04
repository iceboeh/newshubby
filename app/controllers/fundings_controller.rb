class FundingsController < ApplicationController
  before_action :set_funding, only: [:show, :edit, :update, :destroy]

  # GET /fundings
  # GET /fundings.json
  def index
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @fundings = @newsroom.fundings.all
  end

  # GET /fundings/1
  # GET /fundings/1.json
  def show
  end

  # GET /fundings/new
  def new
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @funding = current_newsroom.fundings.new    
  end

  # GET /fundings/1/edit
  def edit
    @fundings = current_newsroom.fundings.friendly.find(params[:id])    
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Not yours to edit!"
    redirect_to :root
  end

  # POST /fundings
  # POST /fundings.json
  def create
    @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    @funding = @newsroom.fundings.create(funding_params)

    respond_to do |format|
      if @funding.save
        format.html { redirect_to [@funding.newsroom, @funding], notice: 'Funding was successfully created.' }
        format.json { render :show, status: :created, location: @funding }
      else
        format.html { render :new }
        format.json { render json: @funding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fundings/1
  # PATCH/PUT /fundings/1.json
  def update
    respond_to do |format|
      if @funding.update(funding_params)
        format.html { redirect_to [@funding.newsroom, @funding], notice: 'Funding was successfully updated.' }
        format.json { render :show, status: :ok, location: @funding }
      else
        format.html { render :edit }
        format.json { render json: @funding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundings/1
  # DELETE /fundings/1.json
  def destroy
    @funding = current_newsroom.fundings.friendly.find(params[:id])
    @funding.destroy
    respond_to do |format|
      format.html { redirect_to fundings_url, notice: 'Funding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding
      @funding = Funding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funding_params
      params.require(:funding).permit(:investment_type, :name, :date, :amount, :newsroom_id)
    end
end
