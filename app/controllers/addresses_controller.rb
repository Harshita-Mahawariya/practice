class AddressesController < ApplicationController

	def index
		render 'new'
	end 
	
	def new
		@address = current_user.addresses.new
	end

	def create
		@address = current_user.addresses.new(address_params)
		if @address.save
			redirect_to home_index_path
		else
			render 'new'
		end
	end

	private

	def address_params
		params.require(:address).permit(:house_no, :building_name, :area_or_colony, :pincode, :city, :state, :near_by_location, :user_id)
	end

end
