class Public::UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @notes = @user.notes
  end

  def edit
  end

  def update
  end
end
