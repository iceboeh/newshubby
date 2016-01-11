class DistributionsController < ApplicationController
  #before_action :set_distribution, only: [:show, :edit, :update, :destroy]
  
  load_and_authorize_resource :newsroom
  load_and_authorize_resource :distribution, :through => :newsroom
  
  respond_to :html

  def index
    @distributions = Distribution.all
    respond_with(@distributions)
  end

  def show
    @press_release = PressRelease.friendly.find(params[:press_release_id])
    @distribution = @press_release.distribution.last
    respond_with(@distribution)
  end

  def new
    @press_release = PressRelease.friendly.find(params[:press_release_id])
    @newsroom = @press_release.newsroom
    @distribution = Distribution.new
    #respond_with(@distribution)
  end

  def edit
    @press_release = PressRelease.friendly.find(params[:press_release_id])
    @distribution = @press_release.distribution.last
    @newsroom = @press_release.newsroom
  end

  def create
    @press_release = PressRelease.friendly.find(params[:press_release_id])
    @newsroom = @press_release.newsroom    
    
    @distribution = @press_release.build_distribution(distribution_params)
    @distribution.save
    redirect_to @distribution
  end

  def update
    @distribution.update(distribution_params)
    respond_with(@distribution)
  end

  def destroy
    @distribution.destroy
    respond_with(@distribution)
  end

  private
    def set_distribution
      @distribution = Distribution.find(params[:id])
      #@press_release = @distribution.press_release.friendly.find(params[:press_release_id])      
    end


    def distribution_params
      params.require(:distribution).permit(:geography, :niche, :comments, :press_release_id, :newsroom_id)
    end
end
