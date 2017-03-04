class ImagesController < ApplicationController
  def index
    @page = params[:page] || 1
    @images = Image.order(created_at: :desc).page(@page)
    render :index, layout: !request.xhr?
  end
end
