module Api
	module V1
		class UsersController < ApiController
			before_action :authenticate_user!
		  before_action :find_user, except: %i[create index]

		  def roles
		    roles = User::ROLE
		    render json: {result: roles}, status: :ok
		  end

		  def index
		  	@user = User.all
		  	render json: {result: @user}, status: :ok
		  end

		  def update
	    	if @user.update(user_params)
	      	render json: {result: @user}, status: :ok
	      else
	      	render json: { errors: @user.errors.full_messages },
	             status: :unprocessable_entity
	      end
		  end

		  def show
		  	render json: {result: @user}, status: :ok
		  	
		  end

		  def destroy
		  	@user.destroy
		  	render json:{ message: "Successfully deleted"}, status: :ok
		  end

			private

			def find_user
			  @user = User.find_by(id: params[:id])
			  rescue ActiveRecord::RecordNotFound
			    render json: { errors: 'User not found' }, status: :not_found
			end

      def user_params
         params.require(:user).permit(:first_name, :last_name, :email, :password, :roles)
       end

		end
	end
end