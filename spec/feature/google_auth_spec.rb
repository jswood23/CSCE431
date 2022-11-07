# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('google auth', type: :feature) do
  describe 'correct mock account' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = nil
      valid_google_login
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      visit new_user_session_path
      find('#google_signin_button').click
    end

    it 'successful login' do
      expect(page).to(have_content('Successfully authenticated from Google account.'))
      expect(page).to(have_content('Authenticated by Google'))
    end

    it 'update email' do
      fill_in 'Email', with: 'test@email.com'
      click_on 'Update'
      expect(page).to(have_content('Your account has been updated successfully.'))
      log_out
      log_in_admin
      visit '/manage_members'
      expect(page).to(have_content('test@email.com'))
      log_out
    end

    it 'update full_name' do
      fill_in 'Full Name', with: 'changed name'
      click_on 'Update'
      expect(page).to(have_content('Your account has been updated successfully.'))
      log_out
      log_in_admin
      visit '/manage_members'
      expect(page).to(have_content('changed name'))
      log_out
    end

    it 'update position' do
      fill_in 'Position', with: 'officer'
      click_on 'Update'
      expect(page).to(have_content('Your account has been updated successfully.'))
    end

    it 'update years active' do
      select '2017', from: 'user[information_attributes][start_year]'
      select '2020', from: 'user[information_attributes][end_year]'
      click_on 'Update'
      expect(page).to(have_content('Your account has been updated successfully.'))
    end

    it 'update phone' do
      fill_in 'Phone', with: '979-999-9999'
      click_on 'Update'
      expect(page).to(have_content('Your account has been updated successfully.'))
    end

    it 'update bios' do
      fill_in 'Bios', with: 'testing bios update'
      click_on 'Update'
      expect(page).to(have_content('Your account has been updated successfully.'))
    end

    it 'update private' do
      check 'Private'
      click_on 'Update'
      expect(page).to(have_content('Your account has been updated successfully.'))
    end
  end

  describe 'mock account with existing email' do
    before do
      visit('/users/sign_up')
      within('#new_user') do
        fill_in('user_full_name', with: 'test account')
        fill_in('user_email', with: 'testing@email.com')
        fill_in('user_password', with: 'password')
        fill_in('user_password_confirmation', with: 'password')
        click_button('Sign up')
      end
      log_out
      OmniAuth.config.mock_auth[:google_oauth2] = nil
      existing_email_login
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it 'member login' do
      before_count = User.count
      visit edit_user_registration_path
      find('#google_signin_button').click
      expect(page).to(have_content('Authenticated by Google'))
      expect(User.count).to(eq(before_count))
    end
  end

  describe 'incorrect mock account' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = nil
      invalid_google_login
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it 'failed login' do
      before_count = User.count
      visit new_user_session_path
      find('#google_signin_button').click
      expect(page).to(have_content('Login'))
      expect(User.count).to(eq(before_count))
    end
  end
end
