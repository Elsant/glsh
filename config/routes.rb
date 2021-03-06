Glash::Application.routes.draw do
  comfy_route :cms_admin, :path => '/cmsadmin'


  # Static Pages
  scope controller: :pages do
    get 'greetings' => :greetings, as: :greetings
    get 'goodbye' => :goodbye, as: :goodbye
    # get 'faq' => :faq,  as: :faq
    # get 'help' =>:help,  as: :help
    # get 'privacy_policy' =>:privacy_policy,  as: :privacy_policy
    # get 'terms' =>:terms,  as: :terms
  end
   
  ActiveAdmin.routes(self)

  # authenticated :user do
  #   root to: "ideas#index", :as => "ideas"
  # end

  root to: "pages#default"
  
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users do
    member do
      get :avatar
      get :load_avatar
    end

    resources :contacts
  end

  resources :ideas do
    member {post :vote, as: :vote}
    member {post :moderate, as: :moderate}

    resources :submit, controller: 'submit'
    resources :assets, except: :destroy
    resources :comments, only: [:create]
    # , only: [:index, :show, :destroy]
  end
  
  resources :assets, only: :destroy
  resources :comments, only: [:index, :destroy] do
    member { post :moderate, as: :moderate}
  end

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', :sitemap => false

  # # ******Shallow*****
  # resources :articles do
  #   resources :comments, only: [:index, :new, :create]
  # end
  # resources :comments, only: [:show, :edit, :update, :destroy]

  # # The same **********
  # resources :articles do
  #   resources :comments, shallow: true
  # end

  
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
