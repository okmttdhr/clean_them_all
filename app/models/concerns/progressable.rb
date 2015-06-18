module Progressable
  extend ActiveSupport::Concern

  module ClassMethods
    def find(id)
      JobProgression.new request_progression(id)
    end

    private

    STATE_MAPPING = {
      :created    => :collecting,
      :collected  => :collecting,
      :filtered   => :destroying,
      :completed  => :completed,
      :aborted    => :aborted,
      :failed     => :failed,
    }.with_indifferent_access

    def request_progression(id)
      item = get_item(id)
      item['current_state'] = STATE_MAPPING.fetch(item['current_state'], '')
      item.symbolize_keys
    end

    def get_item(id)
      ddb = Aws::DynamoDB::Client.new
      ddb.get_item(
        table_name: configatron.aws.ddb.table_name,
        key: {
          id: id,
        }
      ).item
    end
  end
end
