require 'rails_helper'

RSpec.describe 'Visiting the home page', type: :feature do
  scenario 'admin nav bar has full content' do
    visit "/home"
    # main buttons
    expect(page).to have_content('Home')
    expect(page).to have_content('About Us')
    expect(page).to have_content('Events')
    expect(page).to have_content('Contact Us')
    expect(page).to have_content('Log In')
    expect(page).not_to have_content('MCHSO Member')
    expect(page).not_to have_content('MCHSO Admin')
  end

  # scenario 'nav bar member dropdown shows correct content when clicked' do
  #   visit "/home"
  #   click_on 'MCHSO Member'
  #   expect(page).to have_content('My Profile')
  #   expect(page).to have_content('Member List')
  #   expect(page).to have_content('Attend an Event')
  # end

  # scenario 'nav bar admin dropdown shows correct content when clicked' do
  #   visit "/home"
  #   click_on 'MCHSO Admin'
  #   expect(page).to have_content('Manage Events')
  #   expect(page).to have_content('Manage Members')
  #   expect(page).to have_content('Manage Pages')
  # end
end