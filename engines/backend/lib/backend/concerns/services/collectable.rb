module Backend::Concerns::Services::Collectable
  extend ActiveSupport::Concern

  include Backend::Concerns::Services::Collectable::Timeline
  include Backend::Concerns::Services::Collectable::Archive

  def collect
    send collect_method do |status|
      yield status
    end
  end

  private

  def collect_method
    case collect_parameter.collect_method
    when :timeline; :collect_from_timeline
    when :archive;  :collect_from_archive
    end
  end
end
