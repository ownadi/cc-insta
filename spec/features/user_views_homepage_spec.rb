require 'rails_helper'

feature 'User views homepage' do
  scenario 'they see existing images' do
    create :image

    visit root_path

    within '.img-grid' do
      expect(page).to have_selector('div img', count: 1)
    end
  end

  scenario 'they upload new image', js: true do
    visit root_path

    expect(page).to have_selector('.btn-upload', visible: true)
    execute_script "$('#upload-input').show()"

    attach_file 'upload-input', Rails.root.join('spec/fixtures/lena.jpg')

    within '.img-grid' do
      expect(page).to have_selector('div img', count: 1)
    end
  end
end
