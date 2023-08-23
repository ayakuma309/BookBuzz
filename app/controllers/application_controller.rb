class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from Exception, with: :render_500

  # def render_404
  #   render template: 'errors/404', status: :not_found
  # end

  # def render_500(exception = nil)
  #   render template: 'errors/500', status: :internal_server_error
  # end

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
