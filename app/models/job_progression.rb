class JobProgression < Hashie::Dash
  include Progressable

  property :id
  property :current_state
  property :collect_count
  property :filter_count
  property :destroy_count
  property :created_at
  property :updated_at
end
