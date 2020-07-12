class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update] 
  include SessionsHelper
  
  def new
  end

  def edit
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定メールが送信されました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが見つかりません"
      render 'new'
    end
  end
  
  def update
    if params[:user][:password].empty?                 
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)          
      log_in @user
      flash[:success] = "パスワードがリセットされました。"
      redirect_to　root_url
    else
      render 'edit'                                     
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  
    def get_user
      @user = User.find_by(email: params[:email])
    end
    
    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワードのリセットが終了しました。"
        redirect_to new_password_reset_url
      end
    end
end
