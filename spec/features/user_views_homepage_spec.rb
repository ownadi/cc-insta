require 'rails_helper'

feature 'User views homepage' do
  scenario 'they see existing images' do
    create_list :image, 2

    visit root_path

    within '.img-grid' do
      expect(page).to have_selector('div img', count: 2)
    end
  end

  scenario 'they scroll to new page', js: true do
    create_list(:image, 13)

    visit root_path

    # click_on 'btn-load-more'
    execute_script("$('.btn-load-more').click()")

    execute_script('window.scrollBy(0, 100000)')
    expect(page).to have_selector('.img-grid[data-page="2"]')
  end
end
