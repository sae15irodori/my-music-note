class Admin::NoteCommentsController < ApplicationController
  before_action :set_q, only: [:search, :index]

  def create
    @note = Note.find(params[:note_id])
    comment = current_user.note_comments.new(note_comment_params)
    comment.note_id = @note.id
    if comment.save
      flash[:notice] = "コメントを投稿しました✍"
      redirect_to request.referer
    else
      @note_comment = NoteComment.new
      @user = @note.user
      render template: "admin/notes/show"
    end
  end

  def destroy
    if NoteComment.find(params[:id]).destroy
      flash[:notice] = "削除しました"
      redirect_to request.referer
    end
  end

  def index
    @comments = NoteComment.all.order(created_at: :desc)
  end

  def search
    @results = @q.result#set_qメソッドで取得した結果をオブジェクトに変換
  end

  private

  def set_q
    @q = NoteComment.ransack(params[:q])#Noteモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end

  def note_comment_params
    params.require(:note_comment).permit(:comment)
  end

end