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

  describe '#svg_faces' do
    it 'returns valid svg' do
      img = build_stubbed :image, :with_faces

      expected = "<rect x='300' y='177' width='151' height='152' />"
      expect(img.svg_faces).to eq(expected)
    end
  end
end
