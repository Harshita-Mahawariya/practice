Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# root to: redirect('/admin')
# resources :home do
#  get 'product_index', to: 'home#product_index', on: :collection
# end
root to: "home#index"
resources :home
resources :products do
  get 'add_to_cart',to: 'products#add_to_cart'
  get 'like',to: 'products#like'
  get 'unlike', to: 'products#unlike'
  get 'qlike',to: 'products#qlike'
  get 'qunlike', to: 'products#qunlike'
end
resources :categories
resources :carts do
  post 'update_cart', to: 'carts#update_cart'
  delete 'cart_item_destroy', to: 'carts#cart_item_destroy'
end
resources :orders do
  post 'create_order',to: 'orders#create_order', on: :collection
  get 'pay' ,to: 'orders#pay', on: :member
  get 'details', to: 'orders#details',on: :member
end

resources :addresses
resources :queries
resources :likes do
  get 'unlike', to: 'likes#unlike'
end

end
