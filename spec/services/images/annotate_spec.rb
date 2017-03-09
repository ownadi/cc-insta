require 'rails_helper'

describe Images::Annotate do
  describe '#call' do
    it 'calls vision API' do
      img = build :image

      expect(Vision.default_adapter).to receive(:new).and_call_original

      Images::Annotate.new(img).call
    end

    it 'saves tags' do
      img = build :image

      Images::Annotate.new(img).call

      expect(img.tags.sort).to eq(%w(bar foo))
    end

    it 'saves faces' do
      img = build :image

      Images::Annotate.new(img).call

      expected_faces = [[{ 'x' => 300, 'y' => 177 }, { 'x' => 451, 'y' => 177 }, { 'x' => 451, 'y' => 329 }, { 'x' => 300, 'y' => 329 }]]
      expect(img.faces).to eq(expected_faces)
    end
  end
end
