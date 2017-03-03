module Images
  class Create
    def initialize(params)
      @params = params
    end

    def call
      img = Image.create

      ImagesChannel.broadcast_to('images', event: :new_image, contents: ApplicationController.render(img))

      img.file = @params['file'] || @params[:file]
      if img.save && img.reload.file.present?
        ImagesChannel.broadcast_to('images', event: :update_image, id: img.id, contents: ApplicationController.render(img))
      else
        Images::Destroy.new(id: img.id).call
      end
    end
  end
end
