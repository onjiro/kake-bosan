class ApplicationController < ActionController::API
  before_action :authorize
  helper_method :current_user

  private

  # ユーザ認証されていない場合、トップページにリダイレクトする
  def authorize
    redirect_to("/") unless current_user
  end

  # キャッシュ、もしくはセッション情報からユーザー情報を取得する
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
