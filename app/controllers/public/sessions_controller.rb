# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  before_action :authenticate_user!, except: [:top]
  before_action :user_state, only: [:create]

  def after_sign_in_path_for(resource)
    notes_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def user_state#退会しているか確認するﾒｿｯﾄﾞ
    @user = User.find_by(email: params[:user][:email])#入力されたｱﾄﾞﾚｽを基にｱｶｳﾝﾄを取得
    return if !@user#ｱｶｳﾝﾄ存在しない場合このﾒｿｯﾄﾞ終了
      if @user.valid_password?(params[:user][:password]) && @user.is_deleted
        flash[:notice] = "※こちらのアカウントは退会済となっております。ご利用いただくには。o○ トップ画面へ戻りユーザーの新規登録をお願いします"
        redirect_to new_user_session_path
      end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
