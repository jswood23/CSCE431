# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

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

  it 'shows user information fields' do
    log_in_admin
    visit edit_user_registration_path
    expect(page).to(have_content('Position'))
    expect(page).to(have_content('Years active'))
    expect(page).to(have_content('Phone'))
    expect(page).to(have_content('Bios'))
    expect(page).to(have_content('Private'))
    log_out
  end
end
