class Image < ApplicationRecord
  paginates_per 12

  mount_base64_uploader :file, FileUploader, file_name: -> { 'xdd' }
end
