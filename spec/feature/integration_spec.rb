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
  
  before do
    OmniAuth.config.add_mock(:google_oauth2, {:uid => '1337'})
  end

  let(:user) { create(:user) }

  scenario 'Google OAuth Login'
    visit new_user_registration_path
    mock_omniauth
    find("img[src*='/assets/btn_google_signin_light_normal_web.png']").click
    expect(page).to have_content 'Log Out'
  end
end