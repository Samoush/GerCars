Rails.application.routes.draw do

  post 'order_cars/search/by_chassi' => 'order_cars#by_chassi'
  post 'order_cars/search/detailed' => 'order_cars#detailed'
  get 'order_cars/search/by_chassi' => 'order_cars#link_to_by_chassi'
  get 'order_cars/search/detailed' => 'order_cars#link_to_by_detailes'

  get 'competitor_cars/search/by_chassi' => 'competitor_cars#link_to_by_chassi'
  post 'competitor_cars/search/by_chassi' => 'competitor_cars#by_chassi'
  get 'competitor_cars/search/detailed' => 'competitor_cars#link_to_by_detailes'
  post 'competitor_cars/search/detailed' => 'competitor_cars#detailed'

  resources :order_cars
  
  resources :car_templates 
  
  resources :customers 

  resources :competitor_cars

  root 'order_cars#index'      # 'customers#index'    #car_templates
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
