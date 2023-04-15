class Public::NoteCommentsController < ApplicationController
  before_action :is_matching_login_user, only: %i[destroy]
  before_action :guest_check

  def create
    @note = Note.find(params[:note_id])
    comment = current_user.note_comments.new(note_comment_params)
    comment.note_id = @note.id
    if comment.save
      flash[:notice] = "コメントを投稿しました✍"
      #redirect_to request.referer
    else
      @note_comment = NoteComment.new
      @user = @note.user
      render template: "public/notes/show"
    end
  end

  def destroy
    @note = Note.find(params[:note_id])
    if NoteComment.find(params[:id]).destroy!
      flash[:notice] = "コメントを削除しました"
      #redirect_to request.referer
    end
  end

  private

  def note_comment_params
    params.require(:note_comment).permit(:comment)
  end

  def is_matching_login_user
    comment = NoteComment.find(params[:id])
    unless comment.user_id == current_user.id
      redirect_to request.referer
    end
  end

  def guest_check
    if current_user.email == 'guest@gesuto.com'
    redirect_to request.referer,notice: "※コメントをするには...会員登録をしてみましょう♪"
    end
  end
end
