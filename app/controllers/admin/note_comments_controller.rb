class Admin::NoteCommentsController < ApplicationController
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

  private
  def note_comment_params
    params.require(:note_comment).permit(:comment)
  end

end
