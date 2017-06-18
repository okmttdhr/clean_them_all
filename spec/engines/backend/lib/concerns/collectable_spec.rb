require 'rails_helper'

describe Backend::Concerns::Services::Collectable do
  let(:service_class) {
    Class.new do
      include Backend::Concerns::Services::Collectable
      attr_accessor :collect_parameter
    end
  }
  let(:service) { service_class.new }

  describe '#collect' do
    subject { service.collect }

    before do
      allow(service).to receive(:collect_parameter).and_return(parameter)
    end

    context 'when collect_method is timeline' do
      let(:parameter) { double(collect_method: :timeline) }

      before do
        allow(service).to receive(:collect_from_timeline)
      end

      it 'calls #collect_from_timeline' do
        subject
        expect(service).to have_received(:collect_from_timeline)
      end
    end

    context 'when collect_method is archive' do
      let(:parameter) { double(collect_method: :archive) }

      before do
        allow(service).to receive(:collect_from_archive)
      end

      it 'calls #collect_from_archive' do
        subject
        expect(service).to have_received(:collect_from_archive)
      end
    end
  end
end
