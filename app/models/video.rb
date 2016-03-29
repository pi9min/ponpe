# == Schema Information
#
# Table name: videos
#
#  id            :integer          not null, primary key
#  url           :string(255)
#  thumbnail_url :string(255)
#  short_url     :string(4)        not null
#  file_hash     :string(40)
#  title         :string(255)      not null
#  description   :string(255)
#  category      :integer          default(99), not null
#  state         :integer          default(0), not null
#  chapter       :string(255)
#  duration      :integer          default(0), not null
#  recorded_at   :datetime         default(Thu, 01 Jan 1970 00:00:00 UTC +00:00), not null
#  raw_info      :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Video < ActiveRecord::Base
  validates :short_url, length: { in: 1..4 }

  enum category: {
    unknown: 99,
    anime: 0,
    music: 1,
    variety: 2,
    drama: 3,
    cinema: 4,
    sports: 5,
    information: 6,
    news: 7,
    etc: 8
  }

  enum state: {
    registered: 0,
    published: 1,
    archived: 2
  }
end
