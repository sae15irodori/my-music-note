class Admin::UsersController < ApplicationController
  before_action :set_q, only: [:search, :index]

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

  def search
    @results = @q.result#set_qメソッドで取得した結果をオブジェクトに変換
  end

  private

  def set_q
    @q = User.ransack(params[:q])#Userモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end
end
