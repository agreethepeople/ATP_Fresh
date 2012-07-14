ATPFresh::Application.routes.draw do

  root to: 'static_pages#home'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]


  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'



  resources :topics, only: [:index, :show]
  match '/all', to: 'topics#index', via: :get
  #match "/topics/:id" => redirect("/%{Topic.find(:id).slug}")
  match '/:slug/analysis' => 'topics#analysis', via: :get, as: "analysis"

  match '/:slug/agreements' => 'topics#agreements', via: :get #build this
  match '/user/:id/agreements' => 'users#agreements', via: :get #build this

  match '/:slug/agreements/create' => 'agreements#create', via: :post #build this
#  resources :topics do
#    resources :agreements, only: [:create]
#  end

  match '/agreements', to: 'agreements#create', via: :post #gets immediately redirected back to topic
  get "vote/new"
  match '/voting', to: 'votes#create'  #replace this with a form and javascript


  match '/:slug' => 'topics#show', as: "mainpage"


##################################################


  # get "vote/new"

  # resources :users
  # resources :sessions, only: [:new, :create, :destroy]
  # resources :topics, only: [:index, :show]
  # #resources :agreements, only: [:create]

  # resources :topics do
  #   resources :agreements, only: [:create]
  # end

  # resources :votes, only: [:create]



  # root to: 'static_pages#home'
  
  # match '/help',    to: 'static_pages#help'
  # match '/about',   to: 'static_pages#about'
  # match '/contact', to: 'static_pages#contact'

  # match '/signup', to: 'users#new'
  # match '/signin', to: 'sessions#new'
  # match '/signout', to: 'sessions#destroy', via: :delete

  # match '/all', to: 'topics#index', via: :get
  # match '/agreements', to: 'agreements#create', via: :post #gets immediately redirected back to topic
  # match '/voting', to: 'votes#create'  #replace this with a form and javascript


  # match ':title', to: 'topic#show' 
  # .gsub(/ /, '_').gsub(/\./,'')




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
