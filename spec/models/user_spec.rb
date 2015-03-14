# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  token      :string(255)      not null
#  secret     :string(255)      not null
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe User, :type => :model do
  describe '#find_or_create_with_omniauth' do
    subject(:user) { User.find_or_create_with_omniauth(auth) }

    let(:auth) { {
      uid: 1,
      credentials: { token: 'token', secret: 'secret' },
      info: { nickname: 'cohakim' }
    } }

    context 'when user not exists' do
      it { expect{ subject }.to change(User, :count).by(1) }
      its(:id)     { is_expected.to eq 1 }
      its(:token)  { is_expected.to eq 'token' }
      its(:secret) { is_expected.to eq 'secret' }
      its(:name)   { is_expected.to eq 'cohakim' }
    end

    context 'when user exists' do
      before do
        create(:user, id: auth[:uid])
      end

      it { expect{ subject }.not_to change(User, :count) }
      its(:id)     { is_expected.to eq 1 }
      its(:token)  { is_expected.to eq 'token' }
      its(:secret) { is_expected.to eq 'secret' }
      its(:name)   { is_expected.to eq 'cohakim' }
    end
  end

  describe '#has_active_job?' do
    subject { user.has_active_job? }
    let!(:user) { create(:user) }

    context 'when active job exists' do
      let!(:job)  { create(:job, user_id: user.id) }
      it { is_expected.to be_truthy }
    end

    context 'when active job not exists' do
      it { is_expected.to be_falsy }
    end
  end

  describe '#active_job' do
    subject { user.active_job }
    let!(:user) { create(:user) }

    context 'when active job exists' do
      let!(:job) { create(:job, user_id: user.id) }

      it { is_expected.to eq job }
    end

    context 'when active job not exists' do
      it { is_expected.to be_nil }
    end
  end
end
