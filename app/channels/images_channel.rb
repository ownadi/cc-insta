class ImagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'images:images'
  end

  def upload(data)
    CreateImageJob.perform_later(data)
  end
end
