class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render_auth_error unless @current_user
  end

  def authenticate_admin
    render_auth_error unless admin?
  end

  def authenticate_current_user
    render_auth_error unless current_user? || admin?
  end

  private

  def admin?
    @current_user.admin
  end

  def current_user?
    id = params[:id] || params[:user_id]
    @current_user.id.to_s == id
  end

  def render_auth_error
    render json: { error: 'Not Authorized' }, status: 401
  end
end
