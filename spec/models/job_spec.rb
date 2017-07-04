require 'rails_helper'

describe Job do
  describe 'events' do
    describe 'process' do
      subject { job.process! }

      describe 'TimelineFragment' do
        let!(:job) { create :job, :processing }
        let!(:timeline) { create_list :timeline_fragment, Forgery(:basic).number(at_most: 10), job_id: job.id }

        specify '処理完了時に収集したツイートが削除されること' do
          expect { subject }.to change(TimelineFragment, :count).from(timeline.count).to(0)
        end
      end

      describe 'finished_at' do
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
end
