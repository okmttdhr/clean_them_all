class Service::HealthController < ApplicationController
  include Doctorable

  def visible_messages
    count = average_of_messages_visible
    status_code = (count < 20) ? 200 : 503
    render json: count, status: status_code
  end

  def processing_jobs
    count = Job.processing.count
    status_code = (count < 20) ? 200 : 503
    render json: count, status: status_code
  end

  def collecting_jobs
    count = JobProgression.collecting.count
    status_code = (count < 10) ? 200 : 503
    render json: count, status: status_code
  end

  def destroying_jobs
    count = JobProgression.destroying.count
    status_code = (count < 20) ? 200 : 503
    render json: count, status: status_code
  end
end
