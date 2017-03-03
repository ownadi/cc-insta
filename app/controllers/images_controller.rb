class ImagesController < ApplicationController
  def index
    @images = Image.all.order(created_at: :desc)
    render :index, layout: !request.xhr?
  end
end
