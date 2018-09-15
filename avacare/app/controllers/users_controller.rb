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
      render json: @user.id
    else
      render json: 0
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
        render json: @user.id
      else
        render json: 0
      end
    else
      render json: 0
    end
  end

  def doctor
    @response = doctors_in_type("5b33aa692c9dd2435562635a")
    @response2 = closest_doctor(params[:lng], params[:lat], @response)
    puts @response2
    render json: @response2
  end
end
