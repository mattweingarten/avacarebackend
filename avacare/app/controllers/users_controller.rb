class UsersController < ApplicationController
  def new
    @user = User.new(username: params[:username], password: params[:password])
    if(@user.save!)
      render json: @user.id
    else
      render json: -1
    end

  end
  def show
    @user = User.find(params[:id])
    render json: @user
  end
end
