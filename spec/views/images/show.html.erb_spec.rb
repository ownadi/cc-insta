require 'rails_helper'

describe 'images/show.html.erb' do
  context 'image with faced file' do
    let(:img) { build_stubbed(:image, :with_faces) }

    it 'renders annotation svg' do
      assign(:image, img)
      render

      expect(rendered).to have_selector('svg.face-annotations')
    end
  end
end
