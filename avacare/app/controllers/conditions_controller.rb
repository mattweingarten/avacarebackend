class ConditionsController < ApplicationController
  def new
    @condition  = Condition.create(accident: params[:accident],
                                   fever: params[:fever],
                                   user_id: params[:id])
    params[:symptoms].each do |symptom|
      Symptom.create(region: symptom[:region],
                     painlevel: symptom[:painlevel],
                     type: symptom[:type],
                     comment: symptom[:comment],
                     conditon_id: @condition.id)
    end
  end
  def show
    @user = User.find_by(id: params[:id])
    @conditons = @user.conditons
    render json: find_newest(@conditions)
  end
end
