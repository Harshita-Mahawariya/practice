ActiveAdmin.register Product do

  permit_params :name, :image, :category_id,
                 productvariants_attributes: [:id, :name, :place, :price, :stock_quantity, :Description, :_destroy, product_with_variant_properties_attributes: [:id, :productvariant_id, :variant_property_id, :_destroy]]
  config.sort_order = 'id_asc'
  config.per_page = 10
  belongs_to :category, optional: true
  menu priority: 4, :label=> "<i class='fa-warehouse gray-icon'></i> Products".html_safe
  filter :name
  filter :category, as: :check_boxes, collection: Category.all
  config.create_another = true

  sidebar "Title", only: :show do
    attributes_table_for product do
      row :name
    end
  end

  actions :all
  config.clear_action_items!
  action_item :edit, only: :show  do
    link_to I18n.t('active_admin.edit'), edit_resource_path(resource)
  end

  action_item :new, only: :index  do
    link_to 'Add New' , '/admin/products/new'
  end

  action_item :view_site, only: :show do
    link_to "View Site", "/admin/products"
  end

  csv do
      column :category_id
      column :Brand_name
  end
  action_item only: :index do
    link_to 'Upload CSV', action: 'upload_csv'
  end
  collection_action :upload_csv do
    render 'admin/csv/upload_csv'
  end
  collection_action :import_csv, method: :post do
    products = CsvHelper.convert_to_products(params[:dump][:file])
    Product.transaction do
      products.each(&:save!)
    end
    redirect_to({ action: :index }, notice: 'CSV imported successfully!')
    rescue StandardError
    redirect_to({ action: :index },
                flash: { error: 'CSV imported failed! Check the template is correct or contact a developer.' })
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column "Category" do |product|
      text_node "&nbsp;".html_safe
      if product&.category.present?
       link_to product&.category&.name, admin_category_path(product&.category)
      end    
    end
    column :actions do |item|
      links = []
      links << (link_to 'Show', admin_product_path(item))
      links << (link_to 'Delete', admin_product_path(item), method: :delete)
    end
  end

  form do |f|
    panel "Product" do
      f.inputs do
        f.input :category, as: :select, multiple: false, prompt: "select from dropdown"
        f.input :name
        f.input :image, as: :file
        panel "Product Variant" do
          f.has_many :productvariants, allow_destroy: true, heading: ' ', new_record: "Add New Product Variant", remove_record: "Remove Product Variant" , class: "pv_panel" do |a|
            a.input :name, label: "Brand Name"
            a.input :place
            # a.input :price , input_html: { placeholder: "10 % tax will be added to price" }
            # para "10 % tax will be added to price"
            # a.input :stock_quantity
            a.input :Description
            a.has_many :product_with_variant_properties , heading: "<center><b>Variant Property</b></center>".html_safe, allow_destroy: true, new_record: "Add New Variant Property",remove_record: "Remove Variant Property" ,class: "pv" do |b|
              b.input :variant_property, label: "Variant", as: :select, collection: Variant.all.map { |u| [u.name, u.id] }, :prompt => "--select-- variant", multiple: false, input_html: {class: "variant"}
              b.input :variant_property, label: "Variant Property", as: :select, collection: VariantProperty.all.map { |u| [u.name, u.id] }, :prompt => "--select-- property", multiple: false, input_html: {class: "variantP"}
              b.actions
            end
          end
        end
      end
    end
  actions
  end

  show do
    h2 product.name 
    attributes_table do
      row :name 
      row :category
      row :image do |ad|
        image_tag url_for(ad&.image), size: "200x200" if ad&.image.present?
      end
      panel 'Product Variant' do
        table_for product&.productvariants do
          column :name
          column :price do |productvariant|
            "#{productvariant&.price}" + " " + "(final price after adding 10 % tax)"
            end
          column :place
          column :Description
          column "Variant & variant_property" do |pv|
            table_for pv&.product_with_variant_properties do 
              column " " do |pvp|
                pvp&.variant_property&.variant&.name
              end
              column " " do |pvp|
                pvp&.variant_property&.name
              end 
            end
          end
        end
      end
    end
  end

  before_save do |product|
    if params[:product][:productvariants_attributes].present?
      params[:product][:productvariants_attributes].each do |product_variant|
        product_variant_price = product_variant[1][:price]
        if product_variant[1][:id].present?
          productvariant = product.productvariants.find_by(id: product_variant[1][:id])
          if productvariant.present?
            price = product_variant_price.to_i + product_variant_price.to_i / 10
            if productvariant.price != product_variant_price.to_i
              product_variant[1][:price].replace(price.to_s)
            end
          end
        end
      end
    end
  end

  controller do
    def new
      super do 
        a = resource&.productvariants&.build
        b = a&.product_with_variant_properties&.build
        b&.variant_property&.build
      end
    end
    
    def update
      var_name = []
      permitted_params[:product][:productvariants_attributes]&.each {|key,value| var_name&.append(value[:name])}
      if var_name.length != var_name.uniq.length
        flash[:error] = "Duplicate not allowed"
        redirect_to(admin_product_path) and return
      else
        super
      end 
    end
  end
end