require 'rails_helper'

describe 'images/_image.html.erb' do
  context 'image without file' do
    let(:img) { build_stubbed(:image, :invalid) }

    it 'renders non-linked draft image' do
      render partial: 'images/image.html.erb', locals: { image: img }

      expect(rendered).not_to have_selector('a > img')
    end
  end

  context 'image with file' do
    let(:img) { build_stubbed(:image) }

    it 'renders link to image' do
      render partial: 'images/image.html.erb', locals: { image: img }

      expect(rendered).to have_selector("a[href='#{image_path(img)}'] > img")
    end
  end
end
