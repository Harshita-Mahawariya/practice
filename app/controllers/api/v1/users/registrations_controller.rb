
    class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
        respond_to :json

        # private
        skip_before_action :verify_authenticity_token, :only =>:create
        before_action :sign_up_params, only: [:create]

        # def respond_with(resource, _opts = {})
        #   register_success && return if resource.persisted?

        #   register_failed
        # end

        # def register_success
        #   render json: { message: 'Signed up sucessfully.' }
        # end

        # def register_failed
        #   render json: { message: "Something went wrong." }
        # end

        def create
          user = User.new(sign_up_params)
          if user.save
            token = user.generate_jwt
            render json: {token: token, result: user}, status: :ok
          elsif User.find_by(email: user&.email).present?
            render json: { errors: "Email has already been taken" }, status: :unprocessable_entity
          else
            render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
          end
        end

        private
        def sign_up_params
          params.require(:user).permit(:first_name, :last_name, :email, :password, :roles)
        end
      end
 