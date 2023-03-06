class Public::NoteCommentsController < ApplicationController
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
      render template: "public/notes/show"
    end
  end

  def destroy
  end

  private

  def note_comment_params
    params.require(:note_comment).permit(:comment)
  end
end
