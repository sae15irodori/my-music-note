class Public::TagsController < ApplicationController
  before_action :set_q, only: [:search, :index]

  def index
    @tags = Tag.all.page(params[:page]).per(24)
  end

  def show
    @tag = Tag.find(params[:id])
    @tag_notes = @tag.notes.all.order("created_at DESC").joins(:user).merge(User.where(is_deleted: false)).page(params[:page])
    @tag_counts = Note.active_user_notes(@tag)
  end

  def search
    @results = @q.result.page(params[:page]).per(24)#set_qメソッドで取得した結果をオブジェクトに変換
  end

   private

  def set_q
    @q = Tag.ransack(params[:q])#Tagモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end
end