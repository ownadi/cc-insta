require "rails_helper"

feature "User views homepage" do
  scenario "they see existing images" do
    visit root_path

    within '.img-grid' do
      expect(page).to have_selector('div img', count: 12)
    end
  end
end
