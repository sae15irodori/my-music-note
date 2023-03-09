class Public::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  
  def show
    @tag = Tag.find(params[:id])
    @tag_notes = @tag.notes.all.order("created_at DESC")
  end
end