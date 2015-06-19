Rails.application.routes.draw do
  root to: redirect('/cleaner/getstarted')

  # service
  namespace :service do
    get :health, to: 'services#health'
  end

  # omniauth
  scope '/cleaner' do
    post   '/auth/twitter', as: 'signin'
    get    '/auth/:provider/callback', to: 'sessions#create'
    get    '/auth/failure', to: 'sessions#failure'
    match  '/signout', to: 'sessions#destroy', as: 'signout', via: [:get, :delete]
  end

  # cleaner
  resource  :cleaner, except: [:edit, :update] do
    member do
      get    :getstarted
      get    :info
      get    :status
      post   :confirm
      get    :result
      post   :abort
      post   :upload
      post   :report
    end
  end

  # root
  scope '/cleaner' do
    get :usage,   to: 'roots#usage',   as: 'usage'
    get :faq,     to: 'roots#faq',     as: 'faq'
    get :terms,   to: 'roots#terms',   as: 'terms'
    get :privacy, to: 'roots#privacy', as: 'privacy'
    get :contact, to: 'roots#contact', as: 'contact'
  end

  # errors
  ActionDispatch::PublicExceptions.new('public/')
  get '/404', to: 'errors#render_404'
  get '/500', to: 'errors#render_500'
end
