ActiveAdmin.register Productvariant do

  menu false
  permit_params  :product_id, :name, :place, :price, :stock_quantity, :Description
  filter :name
  belongs_to :product, optional: true

  index do
    selectable_column
    id_column
    column :name
    column :place
    column "Product" do |productvariant|
      link_to productvariant&.product&.name, admin_product_path(productvariant&.product)
    end
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do
      f.input :product, as: :select, multiple: false, prompt: "select from dropdown"
      f.input :name
      f.input :place
      f.input :price
      f.input :stock_quantity
    end
    f.actions
  end

  show do
    h1 productvariant.name
    attributes_table do
      row :name
      row :place
      row :price
      row :stock_quantity
    end
  end

end
