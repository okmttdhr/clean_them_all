module Progressable
  extend ActiveSupport::Concern

  module ClassMethods
    def find(id)
      JobProgression.new request_progression(id)
    end

    private

    def request_progression(id)
      if item = get_item(id)
        item.symbolize_keys
      else
        Hash.new
      end
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
