class Image < ApplicationRecord
  mount_base64_uploader :file, FileUploader, file_name: -> { 'xdd' }
end
