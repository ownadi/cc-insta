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
        get :index, xhr: true

        expect(response).not_to render_template('layouts/application')
        expect(response).to render_template('images/index')
      end
    end

    it 'fetches most recent images' do
      expect_any_instance_of(RecentImagesQuery).to receive(:call)

      get :index
    end

    it 'fetches most recent images tagged with given hashtag' do
      expect(RecentImagesQuery).to receive(:new).with('foo', 1)

      get :index, hashtag: 'foo', page: 1
    end
  end

  describe '#destroy' do
    before { allow_any_instance_of(Images::Destroy).to receive(:call) }
    let(:img) { build_stubbed(:image) }

    it 'calls destroy service' do
      expect_any_instance_of(Images::Destroy).to receive(:call)

      delete :destroy, params: { id: img.id }
    end

    context 'in html format' do
      it 'redirects to homepage' do
        delete :destroy, params: { id: img.id }, format: :html

        expect(response).to redirect_to(root_url)
      end
    end

    context 'in json format' do
      it 'responds with no content' do
        delete :destroy, params: { id: img.id }, format: :json

        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe '#show' do
    let(:img) { build_stubbed(:image) }
    before { allow(Image).to receive(:find).and_return(img) }

    it 'assigns image' do
      expect(Image).to receive(:find).with(img.id.to_s).and_return(img)

      get :show, params: { id: img.id }

      expect(assigns(:image)).to eq(img)
    end

    it 'responds with success' do
      get :show, params: { id: img.id }

      expect(response).to render_template('layouts/application')
      expect(response).to render_template('images/show')
      expect(response).to have_http_status(:ok)
    end
  end
end
