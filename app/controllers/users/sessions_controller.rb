class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest#Userモデルからguestメソッドで作ったレコードを取得しuserへ格納
    sign_in user    # ユーザーをsign_in(ﾛｸﾞｲﾝ)させる
    redirect_to notes_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end


