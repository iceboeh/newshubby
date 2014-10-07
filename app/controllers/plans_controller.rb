class PlansController < ApplicationController
  def index
    @plans = Plan.order("price")
    @plans_body = true
  end
  
  def plan_params
    params.require(:plan).permit(:name, :price, :paymill_id, :interval, :currency)
  end
  
end
