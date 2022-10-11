require "rails_helper"

feature "google_auth" do
    before(:each) do
        OmniAuth.config.mock_auth[:google_oauth2] = nil
        valid_google_login
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
    scenario "login" do
        visit new_user_session_path
        find("#google_signin_button").click
        expect(page).to have_content('Successfully authenticated from Google account.')
    end
    scenario "edit oauth" do
        visit new_user_session_path
        find("#google_signin_button").click
        expect(page).to have_content('Successfully authenticated from Google account.')
        visit edit_user_registration_path
        click_on 'Update'
        expect(page).to have_content('Your account has been updated successfully.')
    end
end

feature "google_auth" do
    before(:each) do
        OmniAuth.config.mock_auth[:google_oauth2] = nil
        invalid_google_login
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end
    scenario "failed login" do
        visit new_user_session_path
        find("#google_signin_button").click
        expect(page).to(have_content('Login'))
    end
end