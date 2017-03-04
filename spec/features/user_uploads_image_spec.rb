require 'rails_helper'

feature 'User uploads new image' do
  scenario 'they see uploaded image on page', js: true do
    visit root_path

    expect(page).to have_selector('.btn-upload', visible: true)
    execute_script "$('#upload-input').show()"

    attach_file 'upload-input', Rails.root.join('spec/fixtures/lena.jpg')

    within '.img-grid' do
      expect(page).to have_selector('div img', count: 1)
    end
  end
end
