module Images
  class Annotate
    def initialize(image)
      @image = image
    end

    def call
      vision = Vision.default_adapter.new(@image.file.path)
      tags = vision.labels.map { |label| label.gsub(' ', '').downcase }
      faces = vision.faces
      safe_search = vision.safe_search
      @image.update_attributes(faces: faces, tags: tags, nsfw: !safe_search)
    end
  end
end
