require 'rails_helper'

describe ImagesController do
  describe '#index' do
    context 'non-xhr request' do
      it 'renders template with layout' do
        get :index

        expect(response).to render_template('layouts/application')
        expect(response).to render_template('images/index')
      end
    end

    context 'xhr request' do
      it 'renders template without layout' do
        xhr :get, :index

        expect(response).not_to render_template('layouts/application')
        expect(response).to render_template('images/index')
      end
    end
  end
end
