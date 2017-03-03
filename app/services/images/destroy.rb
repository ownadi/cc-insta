module Images
  class Destroy
    def initialize(params)
      @params = params
    end

    def call
      id = @params[:id] || @params['id']
      Image.find(id).destroy
      ImagesChannel.broadcast_to('images', event: :delete_image, id: id)
    end
  end
end
