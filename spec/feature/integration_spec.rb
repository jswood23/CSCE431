# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Visiting the home page', type: :feature do
  scenario 'Correct content on nav bar' do
    visit "/home"
    expect(page).to have_content('Home')
    expect(page).to have_content('About Us')
    expect(page).to have_content('Events')
    expect(page).to have_content('Contact Us')
    expect(page).to have_content('Log In')
    expect(page).to have_content('Member Pages')

    click_on 'Member Pages'
    expect(page).to have_content('My Profile')
    expect(page).to have_content('Member List')
    expect(page).to have_content('Attend an Event')
  end
end

RSpec.describe 'Test Login', type: :feature do
  scenario 'Correct Login Page'
    visit '/home'
    click_on 'Login'
    expect(page).to have_content('Log In')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Remember Me')
    expect(page).to have_content('Log in')
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Forgot your password?')
  end
end