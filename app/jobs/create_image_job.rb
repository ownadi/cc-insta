class CreateImageJob < ApplicationJob
  queue_as :default

  def perform(params)
    Images::Create.new(params).call
  end
end
