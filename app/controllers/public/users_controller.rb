class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: %i[edit update]
  before_action :guest_check, except: %i[show index]
  before_action :set_q, only: %i[search index]

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
  end

    def favorites
      @user = User.find(params[:id])
      favorites = Favorite.where(user_id: @user.id).pluck(:note_id)#ﾕｰｻﾞｰがいいねした投稿のidをfavoritesへ格納
      @favorite_notes = Note.find(favorites)#いいねした投稿のidをNoteモデルから探す
    end

    def search
      @results = @q.result#set_qメソッドで取得した結果をオブジェクトに変換
    end

    def withdrawal
      @user = User.find(params[:id])
      # is_deletedカラムをtrueに変更することにより削除フラグを立てる
      @user.update(is_deleted: true)
      reset_session
      flash[:notice] = "退会処理が完了しました"
      redirect_to root_path
    end


  private

  def set_q
    @q = User.ransack(params[:q])#Userモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to notes_path
    end
  end

  def guest_check
    if current_user.email == 'guest@gesuto.com'
    redirect_to notes_path,notice: "この操作をするには...会員登録をしてみましょう♪"
    end
  end
end
