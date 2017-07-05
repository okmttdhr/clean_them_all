require 'rails_helper'

describe Job do
  describe 'events' do
    describe 'process' do
      subject { job.process! }

      let!(:job) { create :job, :processing }
      let(:current_time) { Time.zone.now.beginning_of_day }

      before { Timecop.freeze(current_time) }
      after  { Timecop.return }

      specify '処理完了時に処理終了時刻が保存されること' do
        expect { subject }.to change(job, :finished_at).from(nil).to(current_time)
      end
    end
  end
end
