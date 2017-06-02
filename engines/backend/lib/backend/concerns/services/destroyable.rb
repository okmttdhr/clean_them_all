module Backend::Concerns::Services::Destroyable
  extend ActiveSupport::Concern
  include Backend::Concerns::Services::Requestable

  REQUEST_URL = "https://api.twitter.com/1.1/statuses/destroy/%{status_id}.json"

  def destroy(status_ids)
    destroy_with_thread(status_ids) do |status_id|
      retry_count = 0
      begin
        response = post_delete_request(status_id)
        fail if response.code.to_i.in? [500, 502, 503, 504]
      rescue
        if retry_count <= 3
          retry_count += 1
          sleep 1
          retry
        else
          raise
        end
      ensure
        yield status_id, response.body, response.code.to_i
      end
    end
  end

  private

  def destroy_with_thread(status_ids)
    status_ids.map do |status_id|
      Thread.new do
        yield status_id
      end
    end
  end

  def post_delete_request(status_id)
    request_url = REQUEST_URL % { status_id: status_id }
    oauth_client.post request_url
  end
end
