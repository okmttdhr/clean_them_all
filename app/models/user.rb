# == Schema Information
#
# Table name: clean_them_all_users
#
#  id         :integer          not null, primary key
#  token      :string(255)      not null
#  secret     :string(255)      not null
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :jobs

  ##############################################################################
  validates :token, :secret, presence: true

  ##############################################################################

  def self.find_or_create_with_omniauth(auth)
    User.find_or_initialize_by(id: auth[:uid]).tap do |user|
      user.token  = auth[:credentials][:token]
      user.secret = auth[:credentials][:secret]
      user.name   = auth[:info][:nickname]
      user.save!
    end
  end

  ##############################################################################

  def has_active_job?
    jobs.active.present?
  end

  def active_job
    jobs.active.first
  end
end
