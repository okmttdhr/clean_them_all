module Service
  class KpiController < ApplicationController
    def overview
      render json: {
        processing: Job.processing.count,
        collecting: Job.collecting.count,
        cleaning:   Job.cleaning.count,
        tweets:     TimelineFragment.count,
      }
    end

    def registrations
      render json: {
        users: User.count,
        jobs:  Job.count,
      }
    end
  end
end
