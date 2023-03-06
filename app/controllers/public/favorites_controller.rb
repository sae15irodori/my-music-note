class Public::FavoritesController < ApplicationController
  def create
    @note = Note.find(params[:note_id])#いいねする投稿を取得
    favorite = current_user.favorites.new(note_id: @note.id)#ﾛｸﾞｲﾝﾕｰｻﾞｰのfavoritesﾚｺｰﾄﾞを用意note_iにdいいねする投稿のidを渡す
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @note = Note.find(params[:note_id])
    favorite = current_user.favorites.find_by(note_id: @note.id)
    favorite.destroy
    redirect_to request.referer
  end
end
