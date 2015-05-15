class SubscriptionsController < ApplicationController
  before_filter :authenticate_newsroom!

  load_and_authorize_resource :newsroom
  load_and_authorize_resource :subscription, :through => :newsroom

  def new
    @subscription = current_newsroom.build_subscription
  end

  def create
    @subscription = Subscription.new(subscription_params)
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
    params.require(:subscription).permit!
    #(:plan_id, :email, :name, :paymill_card_token, :newsroom_id, :paymill_id, :authenticity_token)
  end
  
end