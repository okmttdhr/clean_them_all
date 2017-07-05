require 'rails_helper'

describe Backend::Concerns::Services::Rescueable do
  let(:service_class) {
    Class.new(ActiveJob::Base) {
      include Backend::Concerns::Services::Rescueable
      def perform; raise_exception; end
      def raise_exception; end
    }
  }
  let(:service) { service_class.new }

  describe 'NETWORK_ERRORS' do
    subject { service.perform_now }
    let(:exception) { Backend::Concerns::Services::Rescueable::NETWORK_ERRORS.sample }

    before do
      allow(service).to receive(:raise_exception).and_raise(exception)
      allow(service).to receive(:logging_exception)
    end

    specify '例外が正しく処理されること' do
      subject
      expect(service).to have_received(:logging_exception)
    end
  end

  describe 'TIMEOUT_ERRORS' do
    subject { service.perform_now }
    let(:exception) { Backend::Concerns::Services::Rescueable::TIMEOUT_ERRORS.sample }

    before do
      allow(service).to receive(:raise_exception).and_raise(exception)
      allow(service).to receive(:logging_exception)
    end

    specify '例外が正しく処理されること' do
      subject
      expect(service).to have_received(:logging_exception)
    end
  end

  describe 'CSV_ERRORS' do
    subject { service.perform_now }
    let(:exception) { Backend::Concerns::Services::Rescueable::CSV_ERRORS.sample }

    before do
      allow(service).to receive(:raise_exception).and_raise(exception)
      allow(service).to receive(:logging_exception_and_fail)
    end

    specify '例外が正しく処理されること' do
      subject
      expect(service).to have_received(:logging_exception_and_fail)
    end
  end

  describe 'Twitter::Error::ServerError' do
    subject { service.perform_now }
    let(:exception) { Twitter::Error::ServerError }

    before do
      allow(service).to receive(:raise_exception).and_raise(exception)
      allow(service).to receive(:logging_exception)
    end

    specify '例外が正しく処理されること' do
      subject
      expect(service).to have_received(:logging_exception)
    end
  end

  describe 'Twitter::Error::ClientError' do
    subject { service.perform_now }
    let(:exception) { Twitter::Error::ClientError }

    before do
      allow(service).to receive(:raise_exception).and_raise(exception)
      allow(service).to receive(:logging_exception_and_fail)
    end

    specify '例外が正しく処理されること' do
      subject
      expect(service).to have_received(:logging_exception_and_fail)
    end
  end

  describe 'Twitter::Error' do
    subject { service.perform_now }

    context 'when Twitter::Error occurred' do
      let(:exception) { Twitter::Error }

      before do
        allow(service).to receive(:raise_exception).and_raise(exception)
        allow(service).to receive(:logging_exception_and_fail)
      end

      specify '例外が正しく処理されること' do
        subject
        expect(service).to have_received(:logging_exception_and_fail)
      end
    end

    context 'when error message includes "execution expired"' do
      let(:exception) { Twitter::Error.new('execution expired') }

      before do
        allow(service).to receive(:raise_exception).and_raise(exception)
        allow(service).to receive(:logging_exception)
      end

      specify '例外が正しく処理されること' do
        subject
        expect(service).to have_received(:logging_exception)
      end
    end

    context 'when error message includes "execution expired"' do
      let(:exception) { Twitter::Error.new('Net::OpenTimeout') }

      before do
        allow(service).to receive(:raise_exception).and_raise(exception)
        allow(service).to receive(:logging_exception)
      end

      specify '例外が正しく処理されること' do
        subject
        expect(service).to have_received(:logging_exception)
      end
    end
  end
end
