require 'rails_helper'

describe Images::Create do
  describe '#call' do
    before { allow(ApplicationController).to receive(:render) }

    context 'with valid file' do
      let(:img_attrs) { attributes_for(:image) }

      it 'pushes events via cable' do
        expect(ImagesChannel).to receive(:broadcast_to).with('images', hash_including(event: :new_image))
        expect(ImagesChannel).to receive(:broadcast_to).with('images', hash_including(event: :update_image))

        expect { Images::Create.new(img_attrs).call }.to change { Image.count }.by(1)
      end
    end

    context 'with invalid file' do
      let(:invalid_img_attrs) { attributes_for(:image, :invalid) }

      it 'deletes draft image' do
        expect_any_instance_of(Images::Destroy).to receive(:call)

        Images::Create.new(invalid_img_attrs).call
      end
    end
  end
end
