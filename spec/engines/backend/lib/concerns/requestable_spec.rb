require 'rails_helper'

describe Backend::Concerns::Services::Requestable do
  let(:service_class) { Class.new { include Backend::Concerns::Services::Requestable } }
  let(:service) { service_class.new }

  pending
end
