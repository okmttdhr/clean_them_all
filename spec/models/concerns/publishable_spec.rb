require 'rails_helper'

shared_examples_for 'publishable' do
  let(:model) { create described_class.name.underscore.to_sym }

  describe '#to_event_message(event)' do
    subject { model.to_event_message(event) }

    context 'when event is create' do
      let(:event) { :create }

      it 'returns JSON' do
        expect { ActiveSupport::JSON.decode(subject) }.not_to raise_error
      end

      specify 'message includes valid parameters' do
        message = ActiveSupport::JSON.decode(subject)
        expect(message).to have_key('id')
        expect(message).to have_key('event')
        expect(message).to have_key('options')
        expect(message['event']).to eq 'created'
      end
    end

    context 'when event is abort' do
      let(:event) { :abort }

      it 'returns JSON' do
        expect { ActiveSupport::JSON.decode(subject) }.not_to raise_error
      end

      specify 'message includes valid parameters' do
        message = ActiveSupport::JSON.decode(subject)
        expect(message).to have_key('id')
        expect(message).to have_key('event')
        expect(message).to have_key('options')
        expect(message['event']).to eq 'aborted'
      end
    end
  end
end
