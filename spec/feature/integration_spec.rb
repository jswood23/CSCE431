# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Visiting the home page', type: :feature do
  scenario 'Correct content on nav bar' do
    visit "/home"
    expect(page).to have_content('Home')
    expect(page).to have_content('About Us')
    expect(page).to have_content('Events')
    expect(page).to have_content('Contact Us')
  end
end