class PlansController < ApplicationController
  def index
    @plans = Plan.order("price")
    @nhBkg = true
    
    @newsroom = current_newsroom
    
    
    # Subscription check
    if @newsroom.subscription.nil? || @newsroom.subscription.end < Time.now
      
      # Payment code check
      @code = @newsroom.code
      @code_match = Code.find_by_code(@code)

      unless @code_match.nil?
        duration = "#{@code_match.duration}.months"
        @newsroom.create_subscription(plan_id: 1, email: @newsroom.email, end: Time.now + eval(duration))     # create subscription with end time X months after signup
        @code_match.destroy      # retire code
      else
        flash[:error] = "Invalid signup code. Try again."
      end
    end
  end
    
  def plan_params
    params.require(:plan).permit!
    #(:name, :price, :paymill_id)
  end
  
end
