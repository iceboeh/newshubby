class SubscriptionsController < ApplicationController
  before_action :set_subscription
  before_filter :authenticate_newsroom!

  load_and_authorize_resource :newsroom
  #load_and_authorize_resource :subscription, :through => :newsroom

  def new
    @subscription = @newsroom.subscription.new
  end

  def create
    @subscription = @newsroom.subscription.new(subscription_params)
    if @subscription.save_with_payment
      redirect_to root_path, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:newsroom_id, :email, :plan_name, :stripe_card_token, :card_number, :card_code)
  end
  
  private
    
    def set_subscription
      @newsroom = Newsroom.friendly.find(params[:newsroom_id])
    end
  
end