require 'rails_helper'

describe Backend::Concerns::Services::Notifyable do
  let(:service_class) {
    Class.new do
      include Backend::Concerns::Services::Notifyable
      attr_accessor :destroy_parameter
    end
  }
  let(:service) { service_class.new }
  let(:twitter_client) { double(:twitter_client).as_null_object }

  before do
    allow(service).to receive(:twitter_client).and_return(twitter_client)
  end

  describe '#notify(context)' do
    context 'when context is start' do
      subject { service.notify(:start) }

      let(:message)   { Forgery(:basic).text }
      let(:parameter) { double(start_message: message) }

      before do
        allow(service).to receive(:destroy_parameter).and_return(parameter)
      end

      specify '開始の通知メッセージが投稿される' do
        subject
        expect(twitter_client).to have_received(:update).with(message)
      end
    end

    context 'when context is finish' do
      subject { service.notify(:finish) }

      let(:message)   { Forgery(:basic).text }
      let(:parameter) { double(finish_message: message) }

      before do
        allow(service).to receive(:destroy_parameter).and_return(parameter)
      end

      specify '終了の通知メッセージが投稿される' do
        subject
        expect(twitter_client).to have_received(:update).with(message)
      end
    end

    context '通知の投稿に失敗したとき' do
      before do
        allow(Bugsnag).to receive(:notify)
        allow(twitter_client).to receive(:update).and_raise('Twitter is over capacity')
      end

      specify 'Bugsnagに報告を上げ処理を継続する' do
        expect { service.notify(:start) }.not_to raise_error
        expect(Bugsnag).to have_received(:notify)
      end
    end
  end
end
