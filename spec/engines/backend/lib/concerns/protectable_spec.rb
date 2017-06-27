require 'rails_helper'

describe Backend::Concerns::Services::Protectable do
  let(:service_class) {
    Class.new {
      include Backend::Concerns::Services::Protectable
      attr_accessor :protect_parameter
    }
  }
  let(:service) { service_class.new }

  describe '#protected_status?(status)' do
    pending
  end

  describe 'protect_after_logged_in?(status)' do
    subject { service.protect_after_logged_in?(status) }

    before do
      allow(service).to receive(:protect_parameter).and_return(parameter)
    end

    context 'ログイン前に投稿されたツイートだった場合' do
      let(:parameter) { double(signedin_at: DateTime.current) }
      let(:status) { { created_at: Forgery(:date).date(past: true).to_s } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end

    context 'ログイン後に投稿されたツイートだった場合' do
      let(:parameter) { double(signedin_at: DateTime.current) }
      let(:status) { { created_at: Forgery(:date).date(future: true).to_s } }

      specify 'ツイートは保護される' do
        expect(subject).to be true
      end
    end

    context 'ログイン日時が取得できない場合' do
      let(:parameter) { double(signedin_at: nil) }
      let(:status) { { created_at: Forgery(:date).date(future: true).to_s } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end
  end

  describe 'protect_before_collect_from?(status)' do
    subject { service.protect_before_collect_from?(status) }

    before do
      allow(service).to receive(:protect_parameter).and_return(parameter)
    end

    context '削除対象日より前に投稿されたツイートだった場合' do
      let(:parameter) { double(collect_from: Time.zone.today) }
      let(:status) { { created_at: Forgery(:date).date(past: true).to_s } }

      specify 'ツイートは保護される' do
        expect(subject).to be true
      end
    end

    context '削除対象日より後に投稿されたツイートだった場合' do
      let(:parameter) { double(collect_from: Time.zone.today) }
      let(:status) { { created_at: Forgery(:date).date(future: true).to_s } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end

    context '削除対象日が設定されていない場合' do
      let(:parameter) { double(collect_from: nil) }
      let(:status) { { created_at: Forgery(:date).date(past: true).to_s } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end
  end

  describe 'protect_after_collect_to?(status)' do
    subject { service.protect_after_collect_to?(status) }

    before do
      allow(service).to receive(:protect_parameter).and_return(parameter)
    end

    context '削除対象日より前に投稿されたツイートだった場合' do
      let(:parameter) { double(collect_to: Time.zone.today) }
      let(:status) { { created_at: Forgery(:date).date(past: true).to_s } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end

    context '削除対象日より後に投稿されたツイートだった場合' do
      let(:parameter) { double(collect_to: Time.zone.today) }
      let(:status) { { created_at: Forgery(:date).date(future: true).to_s } }

      specify 'ツイートは保護される' do
        expect(subject).to be true
      end
    end

    context '削除対象日が設定されていない場合' do
      let(:parameter) { double(collect_to: nil) }
      let(:status) { { created_at: Forgery(:date).date(future: true).to_s } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end
  end

  describe 'protect_reply_status?(status)' do
    subject { service.protect_reply_status?(status) }

    before do
      allow(service).to receive(:protect_parameter).and_return(parameter)
    end

    context 'リプライツイートだった場合' do
      let(:parameter) { double(protect_reply: true) }
      let(:status) { { in_reply_to_user_id: Forgery(:basic).number } }

      specify 'ツイートは保護される' do
        expect(subject).to be true
      end
    end

    context 'リプライツイートでなかった場合' do
      let(:parameter) { double(protect_reply: true) }
      let(:status) { { in_reply_to_user_id: nil } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end

    context '「リプライツイートを保護」がオフだった場合' do
      let(:parameter) { double(protect_reply: false) }
      let(:status) { { in_reply_to_user_id: Forgery(:basic).number } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end
  end

  describe 'protect_favorited_status?(status)' do
    subject { service.protect_favorited_status?(status) }

    before do
      allow(service).to receive(:protect_parameter).and_return(parameter)
    end

    context 'お気に入りされたツイートだった場合' do
      let(:parameter) { double(protect_favorite: true) }
      let(:status) { { favorite_count: Forgery(:basic).number } }

      specify 'ツイートは保護される' do
        expect(subject).to be true
      end
    end

    context 'お気に入りされたツイートでなかった場合' do
      let(:parameter) { double(protect_favorite: true) }
      let(:status) { { favorite_count: 0 } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end

    context '「お気に入りされたツイートを保護」がオフだった場合' do
      let(:parameter) { double(protect_favorite: false) }
      let(:status) { { favorite_count: Forgery(:basic).number } }

      specify 'ツイートは保護されない' do
        expect(subject).to be false
      end
    end
  end
end
