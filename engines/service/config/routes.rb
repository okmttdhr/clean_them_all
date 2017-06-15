Service::Engine.routes.draw do
  # health
  namespace :health, { defaults: { format: :xml } } do
    get :official_account
    get :processing_jobs
    get :collecting_jobs
    get :cleaning_jobs
    get :verify_official_account
  end

  # kpi
  namespace :kpi, { defaults: { format: :xml } } do
    get :overview
    get :registrations
  end

  # sidekiq
  mount Sidekiq::Web => '/sidekiq'
end
