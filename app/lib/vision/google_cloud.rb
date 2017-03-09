require 'google/cloud/vision'

module Vision
  class GoogleCloud
    def initialize(image_path)
      raise if Rails.env.test?

      @image = client.image(image_path)
    end

    def faces
      annotation.faces.map do |face_annotation|
        JSON.parse face_annotation.grpc.fd_bounding_poly.vertices.to_json
      end
    end

    def labels
      annotation.labels.map(&:description)
    end

    private

    def client
      @client ||= Google::Cloud::Vision.new
    end

    def annotation
      @annotation ||= client.annotate @image, faces: true, labels: true
    end
  end
end
