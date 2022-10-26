# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('Mailer', type: :feature) do
  it 'sends password reset email' do
    log_in_member
    member_email = UserHelpers.class_variable_get(:@@member_email)
    log_out
    visit new_user_session_path
    find('#Forgot_Password').click
    fill_in 'Email', with: member_email
    click_on 'Send me reset password instructions'
    expect(Devise.mailer.deliveries.count).to(eq(1))
  end
end
