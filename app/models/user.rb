# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  provider     :string(255)
#  uid          :string(255)
#  access_token :string(255)
#  name         :string(255)
#  email        :string(255)
#  icon_url     :string(255)
#  permission   :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class User < ActiveRecord::Base
  enum permission: {
    guest: 0,
    normal: 1,
    admin: 2
  }

  def self.allowed_users
    permissions.except :guest
  end

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.access_token = auth.credentials.token
      user.name = auth.info.name
      user.email = auth.info.email
      user.icon_url = auth.info.image
      user.save!
    end
  end
end
