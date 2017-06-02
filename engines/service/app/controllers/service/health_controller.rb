module Service
  class HealthController < ApplicationController
    def processing_jobs
      count = Job.processing.count
      status_code = (count < 80) ? 200 : 503
      render json: count, status: status_code
    end

    def collecting_jobs
      count = Job.collecting.count
      status_code = (count < 10) ? 200 : 503
      render json: count, status: status_code
    end

    def cleaning_jobs
      count = Job.cleaning.count
      status_code = (count < 80) ? 200 : 503
      render json: count, status: status_code
    end

    def verify_official_account
      suspended = official_account.suspended?
      status_code = !suspended ? 200 : 503
      render json: !suspended, status: status_code
    rescue => ex
      render json: ex.message, status: 503
    end

    private

    def official_account
      twitter_client.user
    end

    def twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = configatron.twitter.consumer_key
        config.consumer_secret     = configatron.twitter.consumer_secret
        config.access_token        = configatron.twitter.access_token
        config.access_token_secret = configatron.twitter.access_token_secret
      end
    end
  end
end
