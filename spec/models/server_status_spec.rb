require 'rails_helper'

describe ServerStatus, type: :model do
  describe '#busyness_status' do
    subject { ServerStatus.busyness_status }
    it { is_expected.to eq [:empty, :normal, :jam, :halt] }
  end

  describe '#busyness' do
    subject { ServerStatus.busyness }

    before do
      count = double('job_processing', count: processing_count)
      allow(Job).to receive(:processing).and_return(count)
    end

    context '削除処理中のジョブがないとき' do
      let(:processing_count) { 0 }
      it { is_expected.to eq ServerStatus::BUSYNESS_EMPTY }
    end

    context '削除処理中のジョブがあるとき' do
      context '処理中:40個以内の場合' do
        let(:processing_count) { 40 }
        it { is_expected.to eq ServerStatus::BUSYNESS_EMPTY }
      end

      context '処理中:80個以内の場合' do
        let(:processing_count) { 80 }
        it { is_expected.to eq ServerStatus::BUSYNESS_NORMAL }
      end

      context '処理中:240個以内の場合' do
        let(:processing_count) { 240 }
        it { is_expected.to eq ServerStatus::BUSYNESS_JAM }
      end

      context '処理中:240個以上の場合' do
        let(:processing_count) { 241 }
        it { is_expected.to eq ServerStatus::BUSYNESS_HALT }
      end
    end
  end

  describe '#processing_job_count' do
    subject { ServerStatus.processing_job_count }
    let(:job_count) { Forgery(:basic).number }
    before { create_list(:job, job_count, :processing) }
    it { is_expected.to eq job_count }
  end
end
