require 'net/http'
require 'uri'
require 'json'
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  include SymptomsHelper
  include UsersHelper

  def create
    @user = User.new(username: params[:username], secret: params[:secret])

    if(@user.save!)
      render json: {id: @user.id}
    else
      render json: {id: 0}
    end

  end
  def show
    @user = User.find_by_id(params[:id])
    @conditions = @user.conditions
    render json: find_newest(@conditions).symptoms
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user
      if(@user.secret ==  params[:secret])
        render json: {id: @user.id}
      else
        render json: {id: 0}
      end
    else
      render json: {id: 0}
    end
  end

  def doctor
    @user = User.find_by_id(params[:id])
    @condition = find_newest(@user.conditions)
    @symptoms = @condition.symptoms
    @type = doctor_decider(@condition, @symptoms)

    doctors = doctors_in_type(@type)
    puts ".............."
    puts doctors[5]
    puts doctors[5].class
    puts doctors[5]['geocode']
    puts ".............."
    @response2 = closest_doctor(params[:lng], params[:lat], doctors)

    render json: @response2
  end
end
