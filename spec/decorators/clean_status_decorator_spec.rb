require 'rails_helper'
Draper::ViewContext.test_strategy :fast

describe CleanStatusDecorator, type: :decorator do
  let(:clean_status) { double(:clean_status) }
  let(:decorator) { described_class.decorate clean_status }

  describe '#busyness' do
    subject { decorator.busyness }

    let(:symbols) { {
      empty:  I18n.t('default.server_status.empty'),
      normal: I18n.t('default.server_status.normal'),
      jam:    I18n.t('default.server_status.jam'),
      halt:   I18n.t('default.server_status.halt'),
    } }

    it { is_expected.to eq symbols }
  end

  describe '#state_message' do
    subject { decorator.state_message }

    context 'when job state is processing' do
      let(:clean_status) { double(:clean_status, job: job, progression: progression) }
      let(:job) { double(:job, current_state: :processing) }

      context 'when progression state is processing' do
        let(:progression) { double(:progression, current_state: :collecting) }
        it { is_expected.to eq 'ツイート取得中...' }
      end

      context 'when progression state is destroying' do
        let(:progression) { double(:progression, current_state: :destroying, destroyed_count: 5, statuses_count: 10) }
        it { is_expected.to eq '5 / 10' }
      end
    end

    context 'when job state is confirming' do
      let(:clean_status) { double(:clean_status, job: job) }
      let(:job) { double(:job, current_state: :confirming) }
      it { is_expected.to eq '完了!' }
    end
  end

  describe '#state_completion_message' do
    subject { decorator.state_completion_message }

    let(:clean_status) { double(:clean_status, progression: progression) }

    context 'when progression state is completed' do
      let(:progression) { double(:progression, current_state: :completed) }
      it { is_expected.to eq '正常に完了しました' }
    end

    context 'when progression state is failed' do
      let(:progression) { double(:progression, current_state: :failed) }
      it { is_expected.to eq 'エラーが発生し強制終了されました' }
    end

    %i(collecting destroying aborted).each do |state|
      context "when progression state is #{state}" do
        let(:progression) { double(:progression, current_state: state) }
        it { is_expected.to eq 'ユーザによりキャンセルされました' }
      end
    end
  end

  describe '#processing_time' do
    subject { decorator.processing_time }
    let(:clean_status) { double(:clean_status, progression: progression) }
    let(:progression) { double(:progression, created_at: DateTime.now, updated_at: DateTime.now) }

    it { is_expected.to be_kind_of String }
  end
end
