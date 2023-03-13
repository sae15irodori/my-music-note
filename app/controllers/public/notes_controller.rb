class Public::NotesController < ApplicationController
  before_action :is_matching_login_user, only: %i[edit update destroy]
  before_action :guest_check, except: %i[show index]
  before_action :set_q, only: [:search, :index]

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      flash[:notice] = "新しいページを作りました✍"
      redirect_to notes_path
    else
      render :new
    end
  end

  def index
    @notes = Note.all.order(created_at: :desc)
  end

  def show
    @note = Note.find(params[:id])
    @note_comment = NoteComment.new
    @user = @note.user
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      flash[:notice] = "ノートを編集しました"
      redirect_to note_path(@note.id)
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      flash[:notice] = "ノートを消しました"
      redirect_to notes_path
    else
      @note_comment = NoteComment.new
      @user = @note.user
      render :show
    end
  end

  def search
    @results = @q.result#set_qメソッドで取得した結果をオブジェクトに変換
  end

  def tos
  end

  def manual
  end


  private

  def set_q
    @q = Note.ransack(params[:q])#Noteモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end

  def note_params
    params.require(:note).permit(:title, :body, :url, :image, :tag_id)
  end

  def is_matching_login_user
    note = Note.find(params[:id])
    unless note.user.id == current_user.id
      redirect_to notes_path
    end
  end

  def guest_check
    if current_user.email == 'guest@gesuto.com'
    redirect_to notes_path,notice: "※この操作をには✍...会員登録をしてみましょう♪"
    end
  end
end
