RailsYeast::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # See how all your routes lay out with "rake routes"

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  devise_for :users,
    # controllers: {
    #   :registrations => "registrations",
    #   :omniauth_callbacks => 'users/omniauth_callbacks'
    # },
    path: 'u',
    path_names: {
      sign_in: 'in',
      sign_out: 'out',
      password: 'pass',
      confirmation: 'confirm',
      unlock: 'unlock',
      registration: 'reg',
      sign_up: 'new'
    }
  
  resources :contacts, only: [:new, :create]
  resources :resources
  resources :errors
  match 'welcome' => 'resources#welcome'
  match 'about' => 'resources#about'
  match 'privacy' => 'resources#privacy'
  match 'contact' => 'contacts#new'
  root :to => 'resources#welcome'
end
