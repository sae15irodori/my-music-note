class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: %i[edit update favorite]
  before_action :guest_check, except: %i[show index]

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
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを編集しました✍"
      redirect_to user_path(@user.id)
    else
      render :edit
    end

    def favorites
      @user = User.find(params[:id])
      favorites= Favorite.where(user_id: @user.id).pluck(:note_id)#ﾕｰｻﾞｰがいいねした投稿のidをfavoritesへ格納
      @favorite_notes = Note.find(favorites)#いいねした投稿のidをNoteモデルから探す
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to notes_path
    end
  end

  def guest_check
    if current_user.email == 'guest@gesuto.com'
    redirect_to notes_path,notice: "この操作をするには...会員登録をしてみましょう♪"
    end
  end
end
