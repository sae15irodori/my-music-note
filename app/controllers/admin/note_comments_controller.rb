class Admin::NoteCommentsController < ApplicationController
  before_action :authenticate_admin!, if: :admin_url
  before_action :set_q, only: [:search, :index]

  def destroy
    if NoteComment.find(params[:id]).destroy
      flash[:notice] = "削除しました"
      redirect_to request.referer
    end
  end

  def index
    @comments = NoteComment.all.order(created_at: :desc).page(params[:page])
  end

  def search
    @results = @q.result.page(params[:page])
  end

  private

  def set_q
    @q = NoteComment.ransack(params[:q])#Noteモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end

  def note_comment_params
    params.require(:note_comment).permit(:comment)
  end

  def admin_url
    request.fullpath.include?("/admin")
  end


end