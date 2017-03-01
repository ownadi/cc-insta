class ImagesController < ApplicationController
  def index
    render :index, layout: !request.xhr?
  end
end
