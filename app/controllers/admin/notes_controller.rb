class Admin::NotesController < ApplicationController
  before_action :set_q, only: [:search, :index]
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
  
  def search
    @results = @q.result#set_qメソッドで取得した結果をオブジェクトに変換
  end
  
  private
  
  def set_q
    @q = Note.ransack(params[:q])#Noteモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end
  
  
end
