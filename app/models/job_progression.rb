class JobProgression < Hashie::Dash
  include Progressable
  include Hashie::Extensions::Dash::PropertyTranslation

  STATUS = {
    created:   :collecting,
    collected: :collecting,
    filtered:  :destroying,
    completed: :completed,
    aborted:   :aborted,
    failed:    :failed,
  }.with_indifferent_access

  property :id, transform_with: ->(value) { value.to_i }
  property :current_state, default: nil, transform_with: ->(value) { STATUS.fetch(value, :collecting) }
  property :collect_count, default: 0,   transform_with: ->(value) { value.to_i }
  property :filter_count,  default: 0,   transform_with: ->(value) { value.to_i }
  property :destroy_count, default: 0,   transform_with: ->(value) { value.to_i }
  property :created_at, default: DateTime.now
  property :updated_at, default: DateTime.now
end
