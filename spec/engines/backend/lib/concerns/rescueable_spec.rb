require 'rails_helper'

describe Backend::Concerns::Services::Rescueable do
  let(:service_class) { Class.new { include Backend::Concerns::Services::Rescueable } }
  let(:service) { service_class.new }

  pending
end
