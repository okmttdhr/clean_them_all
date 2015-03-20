require 'rails_helper'

describe ServerStatus, type: :model do
  describe '#busyness_status' do
    subject { ServerStatus.busyness_status }
    it { is_expected.to eq [:empty, :normal, :jam, :halt] }
  end

  describe '#busyness' do
    subject { ServerStatus.busyness }

    context '削除処理中のジョブがないとき' do
      it { is_expected.to eq ServerStatus::BUSYNESS_EMPTY }
    end

    context '削除処理中のジョブがあるとき' do
      let!(:job) { FactoryGirl.create(:job, :processing, updated_at: updated_at) }

      context '最遅処理時間:1分以内の場合' do
        let(:updated_at) { 30.seconds.ago }
        it { is_expected.to eq ServerStatus::BUSYNESS_EMPTY }
      end

      context '最遅処理時間:5分以内の場合' do
        let(:updated_at) { 4.minutes.ago }
        it { is_expected.to eq ServerStatus::BUSYNESS_NORMAL }
      end

      context '最遅処理時間:10分以内の場合' do
        let(:updated_at) { 9.minutes.ago }
        it { is_expected.to eq ServerStatus::BUSYNESS_JAM }
      end

      context '最遅処理時間:10分以上の場合' do
        let(:updated_at) { 11.minutes.ago }
        it { is_expected.to eq ServerStatus::BUSYNESS_HALT }
      end
    end
  end

  describe '#processing_job_count' do
    subject { ServerStatus.processing_job_count }
    before { create_list(:job, 3, :processing) }
    it { is_expected.to eq 3 }
  end
end
