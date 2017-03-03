describe Images::Destroy do
  describe '#call' do
    it 'pushes events via cable' do
      image = create(:image)

      expect(ImagesChannel).to receive(:broadcast_to).with('images', hash_including(event: :delete_image))

      expect { Images::Destroy.new(id: image.id).call }.to change { Image.count }.by(-1)
    end
  end
end
