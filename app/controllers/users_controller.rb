class UsersController < ApplicationController
	skip_before_action :require_login, only: %i[new]
  before_action :set_user, only: [:show]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
			flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    current_user.destroy!
    redirect_to root_path, success: t('.success')
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
