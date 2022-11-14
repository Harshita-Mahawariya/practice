class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token, :only =>[:create]
  skip_before_action :verify_signed_out_user

  def create
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      token = user.generate_jwt
      render json: {result: user, token: token, message: "Successfully Logged In."}
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def destroy
      # byebug
    JwtDenylist.find_or_create_by(jti: request.headers['token'], exp: Time.now) if request.headers['token']
    render json: { message: "signed out" }, status: 201
  end

end