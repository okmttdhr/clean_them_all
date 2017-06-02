module Backend
  class DestroyService
    include Backend::Concerns::Services::Destroyable
    include Backend::Concerns::Services::Notifyable

    attr_reader :job, :credentials, :destroy_parameter

    def initialize(job)
      @job               = job
      @credentials       = CredentialParameter.from_job(job)
      @destroy_parameter = DestroyParameter.from_job(job)
    end

    def execute!
      ##########################################################################
      # 開始通知
      unless job.notified_start_message?
        job.update! notified_start_message: true
        notify :start
      end

      ##########################################################################
      # 削除処理
      status_ids = TimelineFragment.where(job_id: job.id).order(:id).limit(100).pluck(:id)
      destroy(status_ids) do |status_id, response_body, response_code|
        # TODO: 失敗数を保存する
      end
      TimelineFragment.where(id: status_ids).delete_all

      # TODO: incrementで更新する
      job.update! destroy_count: (job.destroy_count + status_ids.count)

      ##########################################################################
      # 削除対象ツイートが全て処理されたら完了する
      rest_count = TimelineFragment.where(job_id: job.id).count
      return unless rest_count.zero?
      job.clean!

      ##########################################################################
      # 完了通知
      unless job.notified_finish_message?
        job.update! notified_finish_message: true
        notify :finish
      end
    end
  end
end
