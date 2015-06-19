require 'rails_helper'

shared_examples_for 'progressable' do
  describe '.find' do
    subject { described_class.find Forgery(:basic).number }

    before do
      allow(JobProgression).to receive(:get_item).and_return(progression)
    end

    context 'when progression is nil' do
      let(:progression) { nil }
      it { is_expected.to be_kind_of JobProgression }
    end

    context 'when progression is not nil' do
      let(:progression) { build(:job_progression) }
      it { is_expected.to be_kind_of JobProgression }
    end
  end
end
