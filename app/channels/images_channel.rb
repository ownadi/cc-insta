class ImagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'images:images'
  end

  def upload(data)
    Images::Create.new(data).call
  end
end
