# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('internal/internal_contact.html.erb', type: :feature) do
  it 'shows header' do
    log_in_member
    visit '/internal_contact'
    expect(page).to(have_content('Member Contact Information'))
    log_out
  end

  it 'shows subheaders' do
    log_in_member
    visit '/internal_contact'
    expect(page).to(have_content('Name'))
    expect(page).to(have_content('Member Status'))
    expect(page).to(have_content('Years Active'))
    expect(page).to(have_content('Email'))
    log_out
  end

  it 'shows admin email in table' do
    log_in_admin
    visit '/internal_contact'

    # member is in table
    expect(page).not_to(have_content('No members.'))
    admin_email = UserHelpers.class_variable_get(:@@admin_email)
    member_row = find(:css, '#member_row_1')
    within(member_row) do
      expect(page).to(have_content(admin_email))
    end
  end
end
