module Service
  class KpiController < ApplicationController
    def feed
      @overview      = overview
      @registrations = registrations
      render :feed, content_type: 'application/rss'
    end

    private

    def overview
      {
        processing: Job.processing.count,
        collecting: Job.collecting.count,
        cleaning:   Job.cleaning.count,
        tweets:     TimelineFragment.count,
      }
    end

    def registrations
      {
        users: User.count,
        jobs:  Job.count,
      }
    end
  end
end
