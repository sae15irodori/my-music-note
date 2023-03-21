class Public::TagsController < ApplicationController
  before_action :set_q, only: [:search, :index]

  def index
    @tags = Tag.all.page(params[:page]).per(20)
  end

  def show
    @tag = Tag.find(params[:id])
    @tag_notes = @tag.notes.all.order("created_at DESC")
  end

  def search
    @results = @q.result#set_qメソッドで取得した結果をオブジェクトに変換
  end

   private

  def set_q
    @q = Tag.ransack(params[:q])#Tagモデルより入力されたｷｰﾜｰﾄﾞ(q)を探す
  end
end