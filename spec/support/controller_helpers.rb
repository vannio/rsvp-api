module ControllerHelpers
  def sign_in_as_user
    @current_user = create(:user)
    sign_in(@current_user)
  end

  def sign_in_as_admin
    @current_user = create(:admin)
    sign_in(@current_user)
  end

  private

  def sign_in(user)
    @request.headers[:Authorization] = JsonWebToken.encode(user_id: user.id)
  end
end
