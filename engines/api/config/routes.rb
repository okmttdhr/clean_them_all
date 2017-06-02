Api::Engine.routes.draw do
  scope :v1, { defaults: { format: :json } } do
    resource  :cleaner, only: :show
  end
end
