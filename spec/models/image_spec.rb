require 'rails_helper'

describe Image do
  describe '.tagged_with' do
    it 'searches images with given tag' do
      create :image, tags: ['foo', 'bar']
      create :image, tags: ['foo', 'baz']
      create :image

      expect(Image.tagged_with('foo').count).to eq(2)
      expect(Image.tagged_with('bar').count).to eq(1)
    end
  end
end
