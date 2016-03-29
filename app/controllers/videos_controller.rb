class VideosController < ApplicationController
  def recently
    page = params.key?(:page) ? params[:page] : 0
    @title = '最近録画された動画'
    all_videos = Video.all
    # video connt
    @total = all_videos.count
    @published = all_videos.published.count
    @archived = all_videos.archived.count

    @videos = all_videos.order(recorded_at: :desc).page(page)
  end

  def search
    page = params.key?(:page) ? params[:page] : 0
    keyword = params.key?(:q) ? params[:q] : ''
    @title = "検索結果: #{keyword}"
    hit_videos = Video.where('title LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%").order(recorded_at: :desc)
    # video connt
    @total = hit_videos.count
    @published = hit_videos.published.count
    @archived = hit_videos.archived.count

    @videos = hit_videos.page(page)

    render 'videos/recently'
  end

  def watch
    @video = Video.find_by_short_url(params[:short_url])
    @videos = Video.where(title: @video.title).where.not(short_url: @video.short_url).order(recorded_at: :desc).limit(30)
  end

  def download
    @video = Video.find_by_short_url(params[:short_url])
    filename = @video.title
    filename << (' #' + @video.chapter) unless @video.chapter.blank?
    filename << (' ' + @video.description) unless @video.description.blank?
    filename << '.mp4'
    send_file @video.url, filename: filename
  end

  def category
    page = params.key?(:page) ? params[:page] : 0
    category = params.key?(:category) ? params[:category] : Video.categories[:unknown]

    videos = Video.where(category: Video.categories[category.to_sym]).order(recorded_at: :desc)

    @title = t("videos.categories.#{category}")
    @total = videos.count
    @published = videos.published.count
    @archived = videos.archived.count

    @videos = videos.page(page)

    render 'videos/recently'
  end
end
