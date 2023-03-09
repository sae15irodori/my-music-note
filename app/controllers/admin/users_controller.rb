class Admin::UsersController < ApplicationController
  before_action :set_q, only: %i[search index]
  before_action :guest_check, only: %i[withdrawal unsubscribe]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @notes = @user.notes.order(created_at: :desc)
  end

  def search
    @results = @q.result#set_qメソッドで取得した結果をオブジェクトに変換
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました"
    redirect_to admin_users_path
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  private

  def set_q
    @q = User.ransack(params[:q])#Userモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end

  def guest_check
    user = User.find(params[:id])
    if user.email == 'guest@gesuto.com'
    redirect_to admin_users_path,notice: "※ゲストアカウントは利用停止できません"
    end
  end
end
