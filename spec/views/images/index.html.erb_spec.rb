require 'rails_helper'

describe 'images/index.html.erb' do
  context 'xhr request' do
    before { controller.request.stub(:xhr?) { true } }

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
