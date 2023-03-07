class Public::NotesController < ApplicationController
  before_action :is_matching_login_user, only: %i[edit update destroy]
  before_action :guest_check, except: %i[show index]
  
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      flash[:notice] = "新しいノートを作りました✍"
      redirect_to notes_path
    else
      render :new
    end
  end

  def index
    @notes = Note.all
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
      render :edit
    end
  end


  private

  def note_params
    params.require(:note).permit(:title, :body, :url)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to notes_path
    end
  end
  
  def guest_check
    if current_user.email == 'guest@gesuto.com'
    redirect_to notes_path,notice: "※投稿をするには✍...会員登録をしてみましょう♪"
    end
  end
end
