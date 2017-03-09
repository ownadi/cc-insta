class Image < ApplicationRecord
  scope :tagged_with, ->(tag) { where('tags @> ARRAY[?]', tag) }

  paginates_per 12

  mount_base64_uploader :file, FileUploader, file_name: -> { 'xdd' }

  def svg_faces
    faces.map do |face|
      face = face.sort_by { |point| [point['x'], point['y']] }
      x = face[0]['x']
      y = face[0]['y']
      width = face[-1]['x'] - face[0]['x']
      height = face[-1]['y'] - face[0]['y']
      "<rect x='#{x}' y='#{y}' width='#{width}' height='#{height}' />"
    end.join
  end
end
