# frozen_string_literal: true

require 'rails_helper'
require './spec/support/user_helpers'

RSpec.describe('devise/registrations/edit.html.erb', type: :feature) do
  it 'devise user shows password fields' do
    log_in_admin
    visit edit_user_registration_path
    expect(page).to(have_content('Email'))
    expect(page).to(have_content('Password'))
    expect(page).to(have_content('Password confirmation'))
    expect(page).to(have_content('Current password'))
    log_out
  end
end
