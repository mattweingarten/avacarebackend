class SymptomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include SymptomsHelper
  def create
    @user = User.find_by_id(params[:id])
    @condition  = find_newest(@user.conditions)
    @symptom = Symptom.new(location: params[:location],
                   painlevel: params[:painlevel],
                   type1: params[:type],
                   comment: params[:comment],
                   condition_id: @condition.id)
    
    @symptom.save!
    render json: @condition.symptoms
  end
end
