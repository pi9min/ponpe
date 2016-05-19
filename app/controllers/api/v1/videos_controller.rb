class Api::V1::VideosController < ApplicationController
  protect_from_forgery with: :null_session

  def all
    videos = Video.all.order(recorded_at: :desc)
    render json: videos
  end
end