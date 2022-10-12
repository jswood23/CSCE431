require 'rails_helper'

describe 'google_auth' do
  it 'login' do
    visit new_user_session_path
    find('#google_signin_button').click
    expect(page).to(have_content('Successfully authenticated from Google account.'))
    visit edit_user_registration_path
    click_on 'Update'
    expect(page).to(have_content('Your account has been updated successfully.'))
  end
end
