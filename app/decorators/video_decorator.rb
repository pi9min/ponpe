# coding: utf-8
module VideoDecorator
  def subtitle
    subtitle = ''
    subtitle = "##{chapter} " unless chapter.blank?
    subtitle += description
    subtitle
  end

  def duration_sec
    hours = (duration / 3600).to_i
    minutes = (duration / 60 % 60).to_i
    seconds = (duration % 60).to_i
    if duration < 3600
      format("%02d:%02d", minutes, seconds)
    else
      format("%02d:%02d:%02d", hours, minutes, seconds)
    end
  end

  def recorded_at_txt
    recorded_at.strftime('%Y/%m/%d %H:%M') + ' 放送'
  end

  def download_url
    uri = URI.parse(url)
    # /__dl/{sha1-hash}/{expire unixtime}/{filename}/{videopath}
    expire_time = (Time.zone.now + duration + 6.hours).to_i
    digest_path = File.join(File::SEPARATOR, expire_time.to_s, Base64.urlsafe_encode64(title + ' ' + subtitle + File.extname(url)), uri.path)
    digest = Digest::SHA1.hexdigest(digest_path + Figaro.env.asset_server_salt)
    uri.path = File.join(File::SEPARATOR, '__dl', digest, digest_path)
    uri.to_s
  end

  def short_time_url
    uri = URI.parse(url)
    # /__st/{sha1-hash}/{expire unixtime}/{videopath}
    expire_time = (Time.zone.now + duration + 6.hours).to_i
    digest_path = File.join(File::SEPARATOR, expire_time.to_s, uri.path)
    digest = Digest::SHA1.hexdigest(digest_path + Figaro.env.asset_server_salt)
    uri.path = File.join(File::SEPARATOR, '__st', digest, digest_path)
    uri.to_s
  end

  def thumbnail_small_url(width:)
    uri = URI.parse(thumbnail_url)
    # /__thm/{sha1-hash}/{width}/{videopath}
    digest_path = File.join(File::SEPARATOR, "_#{width}", uri.path) # 192px
    digest = Digest::SHA1.hexdigest(digest_path + Figaro.env.asset_server_salt)
    uri.path = File.join(File::SEPARATOR, '__thm', digest, digest_path)
    uri.to_s
  end

  def line_share_text
    'line://msg/text/' + ERB::Util.url_encode([title, subtitle, short_time_url].join(' '))
  end
end
