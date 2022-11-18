Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  
  namespace :api, constraints: { format: :json } do
      namespace :v1, constraints: { format: :json } do
        devise_for :users, controllers: {
          sessions: 'api/v1/users/sessions',
          registrations: 'api/v1/users/registrations'
        },path: '', path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'signup'
        }
        resources :users do
          get 'roles',to: 'users#roles', on: :collection
        end
        resources :categories
        resources :products do
          get 'add_to_cart' ,to: 'products#add_to_cart'
        end
        resources :carts do
          delete 'cart_item_destroy', to: 'carts#cart_item_destroy', on: :member
          put 'update_cart', to: 'carts#update_cart', on: :member
        end
        resources :orders
        resources :likes do 
          get 'like', to: 'likes#like' ,on: :member
          get 'unlike', to: 'likes#unlike' , on: :member
          get 'Qlike', to: 'likes#Qlike' ,on: :member
          get 'Qunlike', to: 'likes#Qunlike' , on: :member
        end
        resources :queries
      end
    end

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
