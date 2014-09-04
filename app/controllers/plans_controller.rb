class PlansController < ApplicationController
  def index
    @plans = Plan.order("price")
    @plans_body = true
  end
end
