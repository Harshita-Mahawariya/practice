ActiveAdmin.register VariantProperty do

  permit_params :color, :weight, :shape
  menu false
  permit_params :name

end
