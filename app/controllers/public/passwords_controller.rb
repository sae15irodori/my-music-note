# frozen_string_literal: true

class Public::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  before_action :ensure_user, only: :create

  def ensure_user
    if params[:user][:email].downcase == 'guest@example.com'
      redirect_to new_user_session_path, alert: '!ゲストユーザーのパスワードは再設定できません!'
    end
  end
end
