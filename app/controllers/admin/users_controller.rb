class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!, if: :admin_url
  before_action :set_q, only: %i[search index]
  before_action :guest_check, only: %i[withdrawal unsubscribe]

  def index
    users_calculation
  end

  def deleted
    users_calculation
  end

  def total
    users_calculation
  end

  def show
    @user = User.find(params[:id])
    @notes = @user.notes.order(created_at: :desc).page(params[:page])
  end

  def search
    @results = @q.result.page(params[:page])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    flash[:notice] = "#{@user.name}さんの退会処理が完了しました"
    redirect_to admin_users_path
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  private

  def users_calculation
    @users = User.all.order(created_at: :desc).merge(User.where(is_deleted: false)).page(params[:page])
    @deleted_users = User.all.order(created_at: :desc).merge(User.where(is_deleted: true)).page(params[:page])
    @total_users = User.all.page(params[:page])
  end


  def set_q
    @q = User.ransack(params[:q])
  end

  def guest_check
    user = User.find(params[:id])
    if user.email == 'guest@gesuto.com'
    redirect_to admin_users_path,notice: "※ゲストアカウントは利用停止できません"
    end
  end

  def admin_url
    request.fullpath.include?("/admin")
  end
end
