ActiveAdmin.register Cart do

  permit_params :cart_price, :cart_quantity, :account, cart_items: [:cart_item_price, :cart_item_quantity,:product_id, :_destroy]
  belongs_to :account, optional: true
  filter :account_id,as: :select,collection: Account.all.map { |a| [a.fullname,a.id] },prompt: "select"
  index do
    selectable_column
    id_column
    column "Account" do |cart|
    text_node "&nbsp;".html_safe
      if cart&.account.present?
       link_to cart&.account&.name, admin_account_path(cart&.account)
      end
    end
    column :cart_price
    column :cart_quantity
  end

  form do |f|
    panel 'Cart' do
      f.inputs do
        f.input :account_id, as: :select, collection: Account.all.map { |a| [a.fullname, a.id] }, prompt: "select"
        f.input :cart_price
        f.input :cart_quantity
        panel 'Cart Items' do
          f.has_many :cart_items ,allow_destroy: true, heading: ' ', class: "pv_2" do |g|
            g.input :product_id, as: :select, collection: Product.all.map { |a| [a.name, a.id] }, prompt: "select"
            g.input :cart_item_price
            g.input :cart_item_quantity
          end
        end
      end
    end
    actions
  end
  

  show do
    attributes_table do
      row :account
      row :cart_price
      row :cart_quantity
    end
  end

  controller do
    def new
      super do
        # byebug
        resource&.cart_items.build
      end
    end
  end

end
