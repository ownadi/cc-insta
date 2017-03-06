require 'rails_helper'

feature 'User deletes image', js: true do
  scenario 'image disapears' do
    create :image

    visit root_path

    within '.img-grid' do
      expect(page).to have_selector('div img', count: 1)

      sleep 1
      execute_script("$('.image-entry').first().children('.delete-hover').click()")

      expect(page).to_not have_selector('div img')
      expect(Image.count).to eq(0)
    end
  end
end
