Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, controllers: { registrations: 'registrations'}
  resource :users do
 
      get 'dashboard'
      get 'ironyard_dashboard'
      get 'cohort_dashboard'
      patch 'add_user_to_cohort' => 'users#add_user_to_cohort'
      patch 'remove_user_from_cohort' => 'users#remove_user_from_cohort'
      patch 'make_admin' => 'users#make_admin'
 
  end

  resources :courses

  resources :locations

  resources :cohorts

  resources :assignments do
    member do
      get 'submissions'
    end
  end

  resources :submissions do
    member do
      get 'review'
      patch 'resubmit'
    end
  end

  resources :comments do
    collection do
      patch 'accept'
      patch 'reject'
    end
  end

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
