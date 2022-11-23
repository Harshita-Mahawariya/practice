ActiveAdmin.register Variant do

  permit_params :name, variant_properties_attributes: [:id, :name, :_destroy]
  actions :all
  config.clear_action_items!
  menu priority: 5
  member_action :get_variant_property, method: :get do 
    render json: {variant_properties: resource.variant_properties}
  end
  
  action_item :edit, only: :show do
    link_to 'Edit', edit_admin_variant_path(resource&.id)
  end

  action_item :view_site,only: :show do
    link_to 'Variant Index' , '/admin/variants'
  end

  action_item :new, only: :index  do
    link_to 'New Variant' , '/admin/variants/new'
  end

  action_item :view_site,only: :edit do
    link_to 'Variant Index' , '/admin/variants'
  end

  index do
    column :id
    column :name
    column :actions do |item|
      links = []
      links << (link_to 'Show', admin_variant_path(item))
      links << (link_to 'Delete',admin_variant_path(item) , method: :delete, :data => {confirm: "Are you sure you want to delete?"})
    end
  end

  form do |f|
    tabs do
      tab 'Variant' do
        f.inputs do
          f.input :name
          panel 'Variant Property' do
            f.has_many :variant_properties, heading:' ', allow_destroy: true,class: "pv_3", new_record: "Add New" do |a|
              a.input :name
            end
          end
        end
      end
    end
    f.actions
  end

  show do
    h2 variant.name 
    attributes_table do
      row :name 
      columns do 
        column do 
          panel 'Variant Property' do
            attributes_table_for variant&.variant_properties do
              row :name
            end
          end
        end
      end
    end
  end

  controller do
    def update
      var_name = []
      permitted_params[:variant][:variant_properties_attributes].each {|key,value| var_name.append(value[:name])}
      if var_name.length != var_name.uniq.length
        flash[:error] = "Duplicate Variant name not allowed"
        redirect_to edit_admin_variant_path and return
      else
        super
      end 
    end
    def new
      super do
        # byebug
        resource&.variant_properties.build
      end
    end
  end

end