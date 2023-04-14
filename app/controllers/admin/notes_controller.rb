class Admin::NotesController < ApplicationController
  before_action :authenticate_admin!, if: :admin_url
  before_action :set_q, only: %i[search index]

  def index
    @notes = Note.all.order(created_at: :desc).page(params[:page]).per(30)
    @tags = Tag.all.page(params[:page]).per(16).first(8)
  end

  def show
    @note = Note.find(params[:id])
    @note_comment = NoteComment.new
    @user = @note.user
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      flash[:notice] = "ノートを消しました"
      redirect_to admin_notes_path
    end
  end

  def search
    @results = @q.result.page(params[:page]).per(18)#set_qメソッドで取得した結果をオブジェクトに変換
  end

  private

  def set_q
    @q = Note.ransack(params[:q])#Noteモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end

  def admin_url
    request.fullpath.include?("/admin")
  end


end
