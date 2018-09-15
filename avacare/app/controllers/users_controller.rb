class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  include SymptomsHelper

  def create
    p "username:"
    p params.require(:username)
    @user = User.new(username: params[:username], password: params[:password])
    
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
    # ActionController::Parameters.permit_all_parameters = true

    @user = User.find_by(username: params[:username])
    # puts @user.password
    # # p "params: "
    # # p params[:password]
    # puts params
    # p "comparison:"
    # p @user.password == params[:password]
    puts params[:password]
    puts @user.password
    puts @user.password == params[:password]
    if(@user.password ==  params[:password])
      render json: @user.id
    else
      render json: 0
    end
  end
end
