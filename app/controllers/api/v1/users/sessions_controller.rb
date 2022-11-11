class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token, :only =>:create

  def create
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      token = user.generate_jwt
      render json: {result: user, token: token, message: "Successfully Logged In."}
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end