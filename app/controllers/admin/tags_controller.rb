class Admin::TagsController < ApplicationController
  before_action :set_q, only: [:search, :index]

  def index
     @tag = Tag.new
     @tags =Tag.all
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.save
    redirect_to admin_tags_path
  end

  def edit
    @tag =Tag.find(params[:id])
  end

  def update
    tag = Tag.find(params[:id])
    tag.update(tag_params)
    redirect_to admin_tags_path
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
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

  def tag_params
    params.require(:tag).permit(:name)
  end
end
