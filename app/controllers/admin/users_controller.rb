class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @notes = @user.notes
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
  end

  def unsubscribe
  end
end
