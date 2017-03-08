module Vision extend self
  def default_adapter
    if Rails.env.test?
      Vision::Fake
    else
      default = ENV['GOOGLE_CLOUD_VISION_DEFAULT_ADAPTER']
      "Vision::#{default}".constantize
    end
  end
end
