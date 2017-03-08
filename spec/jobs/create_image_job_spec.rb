require 'rails_helper'

RSpec.describe CreateImageJob, type: :job do
  it 'calls create service' do
    params = attributes_for :image

    expect_any_instance_of(Images::Create).to receive(:call)

    CreateImageJob.perform_now(params)
  end
end
