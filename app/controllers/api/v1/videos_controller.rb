class Api::V1::VideosController < ApplicationController
  protect_from_forgery with: :null_session

  def all
    json = { googlevideos: [] }
    videos_recently = Video.all.published.order(recorded_at: :desc).limit(100)
    json[:googlevideos] << {
      category: '最近録画された動画',
      videos: videos_recently.map { |v| { title: v.title, description: self.decorate_description(v.chapter, v.description), studio: 'Ponpe', card: v.thumbnail_url, background: v.thumbnail_url, sources: [self.decorate_short_time_url(v)] }}
    }
    Video.categories.each do |category_name, category_number|
      next if category_name == 'unknown'
      json[:googlevideos] << {
        category: t("enums.video.category.#{category_name}"),
        videos: Video.all.published.where(category: category_number).order(recorded_at: :desc).limit(100).map { |v| { title: v.title, description: self.decorate_description(v.chapter, v.description), studio: 'Ponpe', card: v.thumbnail_url, background: v.thumbnail_url, sources: [self.decorate_short_time_url(v)] }}
      }
    end
    render json: json
  end

  def decorate_description(chapter, description)
    output = []
    output << "##{chapter}" if chapter.present?
    output << description
    output.join(' ')
  end

  def decorate_short_time_url(video)
    uri = URI.parse video.url
    expire_time = (Time.zone.now + video.duration + 6.hours).to_i
    digest_path = File.join(File::SEPARATOR, expire_time.to_s, uri.path)
    digest = Digest::SHA1.hexdigest(digest_path + Figaro.env.asset_server_salt)
    uri.path = File.join(File::SEPARATOR, '__st', digest, digest_path)
    uri.to_s
  end
end
