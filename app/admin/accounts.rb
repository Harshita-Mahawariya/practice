ActiveAdmin.register Account do

  permit_params :fullname, :phoneno, :email, :password, :place, :countrycode, :country, :passcode,
                :userprofile, :uniquenumber, addresses_attributes: [:id, :house_no, :building_name, :area_or_colony, :pincode, :city, :state, :near_by_location, :_destroy]
  menu priority:2
  filter :fullname
  config.sort_order = 'id_asc'
  
  before_create do |resource|
    resource.create_unique_number
    resource.save
  end

  index do
    # table_for accounts do
      selectable_column
      id_column
      # column :userprofile do |a|
      #    image_tag a&.userprofile, size: "20x20" if a&.userprofile.present?
      # end
      column :uniquenumber
      column :fullname
      column :email
      column :country
      actions
    # end
  end

  form do |f|
    panel 'Account' do
      f.inputs do
        f.input :userprofile, as: :file
        f.input :fullname, :wrapper_html => { :class => 'fl' } #for inline
        f.input :countrycode
        f.input :phoneno, :wrapper_html => { :class => 'fl' }
        f.input :email
        f.input :password
        f.input :country, :as => :string
        panel 'Address' do
          f.has_many :addresses, allow_destroy: true, heading: ' ', new_record: "Add Address", remove_record: "Remove Address", class: "pv_1" do |a|
            a.input :house_no
            a.input :building_name
            a.input :area_or_colony
            a.input :pincode
            a.input :city
            a.input :state
            a.input :near_by_location
          end
        end
      actions
      end
    end
  end

  show :title => :fullname do
    attributes_table do
      row :userprofile do |a|
        image_tag a&.userprofile, size: "100x100" if a&.userprofile.present?
      end
      row :fullname
      row :email
      row :countrycode
      row :phoneno
      row :uniquenumber
      row :passcode
      row :country
      panel 'Addresses' do
        table_for account&.addresses do
          column :id
          column :house_no
          column :building_name
          column :area_or_colony
          column :pincode
          column :city
          column :state
          column :near_by_location
        end
      end
    end
  end

  controller do
    
    def create
      super do
        resource.passcode = params[:account][:password]
        redirect_to (admin_accounts_path) and return if resource.save
      end
    end

    def new
      super do
        resource&.addresses&.build
        # byebug
      end
    end
  end

end