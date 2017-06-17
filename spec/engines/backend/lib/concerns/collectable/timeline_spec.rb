require 'rails_helper'

describe Backend::Concerns::Services::Collectable::Timeline do
  let(:service_class) { Class.new { include Backend::Concerns::Services::Collectable::Timeline } }
  let(:service)       { service_class.new }

  describe '#collect_from_timeline' do
    let(:user_timeline)  { YAML.load_file 'spec/fixtures/files/timeline.yml' }
    let(:twitter_client) { double(:twitter_client, user_timeline: user_timeline) }

    before do
      allow(service).to receive(:twitter_client).and_return(twitter_client)
    end

    it 'collects tweets' do
      expect { |b| service.collect_from_timeline(&b) }.to yield_control.exactly(3400)
      expect do
        service.collect_from_timeline do |status|
          expect(status['id']).to be_kind_of String
          expect(status['created_at']).to be_kind_of DateTime
          expect(status['in_reply_to_user_id']).to be_kind_of(String).or be_nil
          expect(status['favorite_count']).to be_kind_of Integer
        end
      end
    end
  end
end
