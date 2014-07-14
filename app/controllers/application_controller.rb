class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authorize
  after_filter :set_csrf_cookie_for_ng

  helper_method :current_user

  protected
  # Angular.js 用に CSRF Protection 対応
  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  private
  # ユーザ認証されていない場合、トップページにリダイレクトする
  def authorize
    redirect_to('/') unless current_user
  end

  # キャッシュ、もしくはセッション情報からユーザー情報を取得する
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Angular.js 用に CSRF Protection 対応
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
end
