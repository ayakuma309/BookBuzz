class ApplicationController < ActionController::Base
  #フラッシュメッセージ
  add_flash_types :success, :info, :warning, :danger
  # ログインを強制するメソッド
  before_action :require_login

  # ログインしていなかった場合に呼ばれるメソッド
  #デフォルトはroot_pathになっている
  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end
end
