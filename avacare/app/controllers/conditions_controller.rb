class ConditionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @condition  = Condition.new(accident: params[:accident],
                                   fever: params[:fever],
                                   user_id: params[:id])
    @condition.save!
    render json:@condition.symptoms
    end
end
