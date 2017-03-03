describe Images::Create do
  describe '#call' do
    it 'pushes events via cable' do
      params = attributes_for(:image)

      expect(ImagesChannel).to receive(:broadcast_to).with('images', hash_including(event: :new_image))
      expect(ImagesChannel).to receive(:broadcast_to).with('images', hash_including(event: :update_image))

      expect { Images::Create.new(params).call }.to change { Image.count }.by(1)
    end

    context 'with invalid file' do
      it 'deletes draft image' do
        params = attributes_for(:image, :invalid)

        expect_any_instance_of(Images::Destroy).to receive(:call)

        Images::Create.new(params).call
      end
    end
  end
end
