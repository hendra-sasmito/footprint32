require 'sidekiq/web'

Footprint32::Application.routes.draw do

  mount Peek::Railtie => '/peek'
  
  get "messages/auto_complete_for_friend_name"
  get "messages/get_recipient"
  #post "messages/mark_as_unread"
  #post "messages/reply"
  resources :messages do
    post :reply, :on => :collection
    get :search, :on => :collection
    member do
      post :unread
    end
  end


  match "/401", to: "errors#unauthorized"
  match "/404", to: "errors#not_found"
  match "/500", to: "errors#error"

  get "profile_photo/show_photos"
  post "profile_photo/select_photo"
  post "profile_photo/create"
  post "profile_photo/save_offset"

  #get "cover_photo/show_photos"
  #post "cover_photo/select_photo"
  #post "cover_photo/create"

  get "help/about"
  get "help/cookies"
  get "help/index"
  get "help/terms"

#  get "autocomplete_cities/index"
#  get "autocomplete_places/index"

  match '/search/json_search', to: 'search#json_search', as: 'json_search'

  resources :authentications

  resources :regions, only: [:index, :show]

  resources :activities, only: [:index, :show]

  resources :countries, :only => [:show, :index] do
    get :autocomplete_country_name, :on => :collection
  end

  post "cities/check_in"
  resources :cities, :only => [:show, :index, :edit, :update, :new, :create] do
    get :autocomplete_city_name, :on => :collection
    get :upload_photo
    get :get_places, :on => :collection
    get :get_like
    get :get_visited
  end

  resources :comments, :only => [:show, :create, :edit, :update, :destroy] do
    get :retrieve, :on => :collection
  end

  resources :categories, only: [:index, :show]

  post "friendship/create"
  post "friendship/accept"
  post "friendship/decline"
  post "friendship/cancel"
  post "friendship/delete"
  get "friendship/show"
  get "friendship/friends"

  get "search/index"
  get "search/autocomplete_place_city_name"

  get "events/monthly_events"

  resources :reviews, :except => [:index] do
    member { post :vote }
  end

  get "places/discover"
  post "places/check_in"
  resources :places, :except => [:destroy] do
#    get :autocomplete_place_name, :on => :collection
    get :autocomplete_place_name, :on => :collection
    get :upload_photo
    get :get_like
    get :get_visited
  end

#  resources :autocomplete_places, :only => [:index]
#
#  resources :autocomplete_cities, :only => [:index]

  get "home/index"
  get "home/news_feed"
  get "home/updates"
  get "home/users"

  #devise_for :users
#  ActiveAdmin.routes(self)

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions", :omniauth_callbacks => "users/omniauth_callbacks" }
    
#  devise_scope :user do
#    resource :registration,
#      only: [:new, :create, :edit, :update],
#      path: 'users',
#      path_names: { new: 'sign_up' },
#      controller: 'registrations' #,
#      as: :user_registration do
#        get :cancel
#      end
#  end
#  ActiveAdmin.routes(self)

  resources :users do
    resources :shares, :only => [:index, :edit, :update]
    resources :reports
    resource :profile, :only => [:show, :edit, :update]
    resources :events
    resources :trips do
      post :set_selected, :on => :collection
      get :ajax_read_all_data, :on => :collection
    end
    resources :favorite_places, :only => [:create, :destroy, :index]
    resources :visited_places, :only => [:create, :index, :destroy]
    resources :favorite_cities, :only => [:create, :destroy, :index]
    resources :visited_cities, :only => [:create, :index, :destroy]

    resources :photo_albums do
      get :autocomplete_photo_album_name, :on => :collection
      resources :photos, :except => [:index] do
        member do
         post :set_as_profile
       end
      end
    end
  end

#  mount Judge::Engine => '/judge'

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

  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  authenticated :user do
    root :to => 'home#index'
  end
  devise_scope :user do
    root :to => "devise/sessions#new"
  end
  

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

#  mount Sidekiq::Web, at: "/sidekiq"

  # only admin can access sidekiq
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'

        post 'sessions' => 'sessions#create', :as => 'login'
        post 'passwords' => 'passwords#create', :as => 'password'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
      get 'tasks' => 'tasks#index', :as => 'tasks'
    end
  end
  
end
