require 'rails_helper'

describe 'images/index.html.erb' do
  before do
    assign(:images, Image.all.page(1))
  end

  context 'xhr request' do
    before { allow(controller.request).to receive(:xhr?).and_return(true) }

    it 'does not render load more button' do
      render

      expect(rendered).not_to have_selector('.load-more')
    end
  end

  context 'non-xhr request' do
    it 'renders load more button' do
      render

      expect(rendered).to have_selector('.load-more')
    end
  end
end
