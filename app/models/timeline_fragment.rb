# == Schema Information
#
# Table name: timeline_fragments
#
#  id     :integer          not null, primary key
#  job_id :integer          not null
#
# Indexes
#
#  index_timeline_fragments_on_job_id  (job_id)
#

class TimelineFragment < ApplicationRecord
  def self.import_with_buffer
    Buffer.new.tap do |buffer|
      yield buffer
      buffer.flush
    end
  end

  class Buffer
    attr_reader :buffer

    def initialize
      @buffer = []
    end

    def add(vals)
      buffer << vals
      flush if buffer.size >= 1000
    end

    def flush
      TimelineFragment.import [:id, :job_id], buffer
      buffer.clear
    end
  end
end
