require 'rails_helper'

feature 'User deletes image', js: true do
  scenario 'by click on homepage hover' do
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

  scenario 'by click on delete button', js: true do
    img = create :image

    visit image_path(img)
    click_on I18n.t('image.destroy_button')

    expect(page.current_path).to eq('/')
    within '.img-grid' do
      expect(page).to_not have_selector('div img')
    end
  end
end
