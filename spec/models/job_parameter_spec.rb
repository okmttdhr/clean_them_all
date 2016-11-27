# == Schema Information
#
# Table name: clean_them_all_job_parameters
#
#  id               :integer          default(0), not null, primary key
#  signedin_at      :datetime         not null
#  statuses_count   :integer          not null
#  registered_at    :datetime         not null
#  collect_method   :string(255)      not null
#  archive_url      :text(65535)
#  protect_reply    :boolean          default(FALSE)
#  protect_favorite :boolean          default(FALSE)
#  collect_from     :date
#  collect_to       :date
#  start_message    :string(255)
#  finish_message   :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

describe JobParameter, type: :model do
  describe '#extras=' do
    subject { job_parameter }

    let(:job_parameter) { build(:job_parameter) }
    let(:extras) { {
      signedin_at: Time.zone.local(2014, 1, 1),
      statuses_count: 2014,
      registered_at: Time.zone.local(2014, 1, 1),
    } }

    before do
      job_parameter.extras = extras
    end

    its(:signedin_at)    { is_expected.to eq extras[:signedin_at] }
    its(:statuses_count) { is_expected.to eq extras[:statuses_count] }
    its(:registered_at)  { is_expected.to eq extras[:registered_at] }
  end
  describe '#options=' do
    subject { job_parameter }

    let(:job_parameter) { build(:job_parameter) }
    let(:options) { {
      collect_method:   'archive',
      archive_url:      'http://example.com/archive',
      protect_reply:    true,
      protect_favorite: true,
      collect_from:     Time.zone.local(2014, 1, 1),
      collect_to:       Time.zone.local(2014, 1, 1),
      start_message:    'start!',
      finish_message:   'finish!'
    } }

    before do
      job_parameter.options = options
    end

    its(:collect_method)   { is_expected.to eq options[:collect_method] }
    its(:archive_url)      { is_expected.to eq options[:archive_url] }
    its(:protect_reply)    { is_expected.to eq options[:protect_reply] }
    its(:protect_favorite) { is_expected.to eq options[:protect_favorite] }
    its(:collect_from)     { is_expected.to eq options[:collect_from].to_date }
    its(:collect_to)       { is_expected.to eq options[:collect_to].to_date }
    its(:start_message)    { is_expected.to eq options[:start_message] }
    its(:finish_message)   { is_expected.to eq options[:finish_message] }
  end
end
