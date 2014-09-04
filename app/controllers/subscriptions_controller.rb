class SubscriptionsController < ApplicationController
  before_filter :authenticate_newsroom!

  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save_with_payment
      redirect_to wizard_path(:logo), :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:plan_id, :email, :name, :paymill_card_token, :newsroom_id, :paymill_id)
  end
  
end
