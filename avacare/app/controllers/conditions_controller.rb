class ConditionsController < ApplicationController
  include SymptomsHelper
  skip_before_action :verify_authenticity_token
  def create
    @condition  = Condition.new(accident: params[:accident],
                                   fever: params[:fever],
                                   user_id: params[:id])
    @condition.save!
    render json:@condition.symptoms
  end

  def index
    @conditions = Condition.where(user_id: params[:id])
    @symptoms = find_newest(@conditions).symptoms
    puts @symptoms
    render json:{symptoms: @symptoms }
  end
end
