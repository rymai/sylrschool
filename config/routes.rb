Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :grades

  resources :grades
  resources :presents

  resources :teachings

  resources :teachings
  resources :presents
  resources :schedules

  resources :locations

  resources :grade_contexts

  resources :elements

  resources :class_schools

  resources :notebooks

  resources :matters

  resources :teachers

  resources :responsibles

  resources :students

  resources :skills

  resources :notebooks
  resources :student_responsibles
  resources :teacher_matters
  resources :student_responsibles

  match 'users', to: 'users#index', via: [:get]
  match 'users/:id', to: 'users#destroy', via: [:delete]

  devise_for :users, controllers: {
        sessions: 'users/sessions',registrations: "users/registrations"
      }

  resources :grade_contexts
  resources :teachers
  resources :students
  resources :responsibles
  resources :matters
  resources :elements
  resources :schedules
  resources :class_schools
  resources :locations

  # config/routes.rb
  root :to => 'main#index'

  resources :main do
  # controller :main
    collection do
      get :tools
      get :index_actions
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
