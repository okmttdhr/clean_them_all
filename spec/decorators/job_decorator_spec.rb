require 'rails_helper'

describe JobDecorator, type: :decorator do
  let(:decorator) { create(:job).decorate }

  describe '#processing_time' do
    subject { decorator.processing_time }
    it { is_expected.to be_kind_of String }
  end

  describe '#state_of_completion' do
    subject { decorator.state_of_completion }

    context 'when job failed' do
      before do
        decorator.progression.update(aasm_state: :failed)
      end
      it { is_expected.to eq 'エラー中断' }
    end

    context 'when job succeeded' do
      it { is_expected.to eq '正常に完了' }
    end
  end
end
