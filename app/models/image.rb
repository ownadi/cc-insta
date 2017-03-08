class Image < ApplicationRecord
  scope :tagged_with, ->(tag) { where('tags @> ARRAY[?]', tag) }

  paginates_per 12

  mount_base64_uploader :file, FileUploader, file_name: -> { 'xdd' }
end
