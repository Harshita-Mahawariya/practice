ActiveAdmin.register Category do

  permit_params :name
  config.comments = false
  menu priority:3

  index do
    column :id
    column :name
    column :actions do |item|
      links = []
      links << (link_to 'Edit',edit_admin_category_path(item))
      links << (link_to 'Delete', admin_category_path(item), method: :delete, :data => {confirm: "Are you sure you want to delete?"})
    end
  end

  form do |f|
    tabs do
      tab 'Category' do
        f.inputs do
          f.input :name
        end
      end
    end
    actions
  end

end