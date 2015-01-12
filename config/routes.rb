Rails.application.routes.draw do
 # ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)
  resources :pressrelease_types

  get '/about' => 'contacts#about'
  get '/terms_of_service' => 'newsrooms#terms_of_service'
  get '/pressreleasetype' => 'company_launches#type'
  get '/select' => 'press_releases#select'
  get '/pressreleases' => 'newsrooms#allpressreleases'
  
  resources :plans do
    get :free, on: :collection
    get :premium, on: :collection
  end

  resources :subscriptions

  resources :introduction
  
  resources :contacts

  resources :newsrooms, :path => '/' do
    get :autocomplete_press_release_title, :on => :collection
    resources :press_releases, path: 'pressreleases'
    #resources :company_launches, :path => 'pressreleases'
    resources :people
    resources :fundings, :path => 'funding'
  end

  root "newsrooms#index"

  devise_for :newsrooms, :controllers => { :registrations => "registrations" }
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
