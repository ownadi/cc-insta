module Images
  class Annotate
    def initialize(image)
      @image = image
    end

    def call
      vision = Vision.default_adapter.new(@image.file.path)
      tags = vision.labels.map { |label| label.gsub(' ', '').downcase }
      faces = vision.faces
      @image.update_attributes(faces: faces, tags: tags)
      @image.save
    end
  end
end
