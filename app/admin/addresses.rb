ActiveAdmin.register Address do

  permit_params :house_no, :building_name, :area_or_colony, :pincode, :city, :state, :near_by_location
  config.comments = false
  menu false

  index do
    column :id
    column :state
    column :city
    column :pincode
    actions
  end
  
end