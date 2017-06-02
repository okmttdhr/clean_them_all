module Service
  class KpiController < ApplicationController
    def overview
      @item = {
        processing: Job.processing.count,
        collecting: Job.collecting.count,
        cleaning:   Job.cleaning.count,
        tweets:     TimelineFragment.count,
      }
      render :overview, content_type: 'application/rss'
    end

    def registrations
      @item = {
        users: User.count,
        jobs:  Job.count,
      }
      render :registrations, content_type: 'application/rss'
    end
  end
end
