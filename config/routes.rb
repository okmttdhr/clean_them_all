Rails.application.routes.draw do
  root to: redirect('/cleaner/getstarted')

  # roots
  direct :blog { 'http://clean-them-all.tumblr.com/' }
  scope '/cleaner' do
    get :getstarted, to: 'roots#show'
    get :usage,      to: 'roots#usage',   as: 'usage'
    get :faq,        to: 'roots#faq',     as: 'faq'
    get :terms,      to: 'roots#terms',   as: 'terms'
    get :privacy,    to: 'roots#privacy', as: 'privacy'
    get :contact,    to: 'roots#contact', as: 'contact'
  end

  # omniauth
  scope '/cleaner' do
    match '/auth/twitter', via: [:post], as: 'signin'
    match '/auth/:provider/callback', to: 'sessions#create',  via: [:get, :post]
    match '/auth/failure',  to: 'sessions#failure', via: [:get, :post]
    match '/signout', to: 'sessions#destroy', via: [:get, :delete], as: 'signout'
  end

  # cleaner
  resource  :cleaner, except: [:edit, :update] do
    get  :info
    post :upload
    post :abort
    post :confirm
  end

  # API
  mount Api::Engine => '/api'

  # Service
  mount Service::Engine => '/service'
end
