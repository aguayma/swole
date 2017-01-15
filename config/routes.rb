Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  # root "users#index"
  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

  get 'my-dashboard', to: 'users#my_dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'store' => 'product#index'
  get 'store/product/:id' => 'product#show', as: 'product'
  post 'user/purchase' => 'users#purchase', as: 'purchase'
end
