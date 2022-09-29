require 'rails_helper'
require './spec/support/user_helpers'

RSpec.configure do |c|
  c.include UserHelpers
end

RSpec.describe 'Visiting the home page', type: :feature do
  before(:all) do
    create_accounts()
  end

  scenario 'nav bar for non-user shows correct content' do
    visit "/home"
    # main buttons
    expect(page).to have_content('Home')
    expect(page).to have_content('About Us')
    expect(page).to have_content('Events')
    expect(page).to have_content('Contact Us')

    expect(page).not_to have_content('MCHSO Member')
    expect(page).not_to have_content('MCHSO Admin')
    
    expect(page).to have_content('Login')
    expect(page).to have_content('Create Account')
  end

  scenario 'nav bar member dropdown shows correct content when clicked' do
    log_in_member()
    visit "/home"
    expect(page).to have_content('MCHSO Member')
    click_on 'MCHSO Member'
    expect(page).to have_content('My Profile')
    expect(page).to have_content('Member List')
    expect(page).to have_content('Attend an Event')
    expect(page).not_to have_content('MCHSO Admin')
  end

  # scenario 'nav bar admin dropdown shows correct content when clicked' do
  #   visit "/home"
  #   click_on 'MCHSO Admin'
  #   expect(page).to have_content('Manage Events')
  #   expect(page).to have_content('Manage Members')
  #   expect(page).to have_content('Manage Pages')
  # end
end