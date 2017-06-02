module Backend
  class CredentialParameter
    attr_accessor :user_id, :consumer_key, :consumer_secret, :access_token, :access_token_secret

    def self.from_job(job)
      CredentialParameter.new.tap do |obj|
        obj.user_id             = job.user.id
        obj.consumer_key        = configatron.twitter.consumer_key
        obj.consumer_secret     = configatron.twitter.consumer_secret
        obj.access_token        = job.user.token
        obj.access_token_secret = job.user.secret
      end
    end
  end
end
