require 'rails_helper'

describe TimelineFragment do
  describe '.import_with_buffer' do
    let!(:old_job)  { create :job }
    let!(:new_job)  { create :job }
    let!(:timeline) { create_list :timeline_fragment, 10, job_id: old_job.id }

    specify 'IDの重複があった場合、新しいJOB_IDに更新する' do
      expect {
        timeline.each do |status|
          TimelineFragment.import_with_buffer do |buffer|
            buffer.add([status.id, new_job.id])
          end
        end
      }.to change {
        TimelineFragment.where(job_id: old_job.id).count
      }.from(10).to(0).and change {
        TimelineFragment.where(job_id: new_job.id).count
      }.from(0).to(10)
    end
  end
end
