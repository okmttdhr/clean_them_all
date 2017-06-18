require 'rails_helper'

describe Backend::Concerns::Services::Destroyable do
  let(:service_class) { Class.new { include Backend::Concerns::Services::Destroyable } }
  let(:service) { service_class.new }

  let(:response) { double('response', body: Forgery('basic').text, code: status_code) }
  let(:oauth_client) { double('Oauth Client', post: response) }

  before do
    stub_const('Backend::Concerns::Services::Destroyable::RETRY_INTERVAL', 0)
    allow(Thread).to receive(:new).and_yield
    allow(service).to receive(:oauth_client).and_return(oauth_client)
  end

  describe '#destroy(status_ids)' do
    let(:status_ids) { [1, 2, 3, 4, 5] }

    context 'when request results in success' do
      let(:status_code) { 200 }

      specify do
        expect { |b| service.destroy(status_ids, &b) }.to yield_control.exactly(5)
        service.destroy(status_ids) do |status_id, body, code|
          expect(status_id).to be_in(status_ids)
          expect(body).to be_kind_of String
          expect(code).to eq 200
        end
      end
    end

    context 'when request results in failure' do
      let(:status_code) { 500 }

      specify do
        expect { service.destroy(status_ids) { } }.to raise_error(RuntimeError)
        service.destroy(status_ids) do |status_id, body, code|
          expect(status_id).to be_in(status_ids)
          expect(body).to be_kind_of String
          expect(code).to eq 500
        end rescue nil
      end
    end
  end
end
