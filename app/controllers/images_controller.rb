class ImagesController < ApplicationController
  def index
    @page = params[:page] || 1
    @images = RecentImagesQuery.new(params['hashtag'], @page).call
    render :index, layout: !request.xhr?
  end

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    Images::Destroy.new(params).call

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head 204 }
    end
  end
end
