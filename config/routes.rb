MobileTest::Application.routes.draw do
  get "password_resets/new"

  root :to => 'homes#log_in', :as => "log_in" 
  
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "menu" => "homes#menu", :as => "menu" 
  
  resources :posts
  resources :comments do
    get 'checked', :on => :member
  end
    
  resources :sessions
  resources :dashboards
  resources :guidepdfs
  resources :guidenotes
  resources :guidedownloads
  resources :standards
  resources :standardsubsections
  
  resources :sections
  resources :subsections
  resources :clauses do
    get 'show_guide', :on =>:member
    get 'delete_guidenote', :on =>:member
    get 'clone_subsection', :on =>:member
    get 'clone_clause', :on =>:member
    get 'edit_guidenote', :on =>:member
  end
  resources :guidenotes do
      get 'single_edit', :on =>:member
  end
  resources :txt3s
  resources :txt4s
  resources :txt5s
  resources :clausetitles
  
  resources :templates do
    collection do
      post "import"
      get "export"
    end
  end
  
  resources :activities
  resources :admins do
    get 'change', :on => :member
  end      
  
  resources :users do
    get 'unlock', :on => :member
  end
  resources :accounts do
    get 'add_licence', :on => :member
    get 'minus_licence', :on => :member
  end  

  resources :sponsors
  resources :suppliers

  resources :password_resets

  resources :exports do 
    get :clausetype_4_download, :on => :member
    get :clausetype_5_download, :on => :member
    get :linetype_change, :on => :member
    get :clausetype_update, :on => :member
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
