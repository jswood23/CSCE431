require 'rails_helper'
require './spec/support/user_helpers'

RSpec.describe "admin/manage_members.html.erb", type: :feature do
  # @@email_admin = UserHelpers.class_variable_get(:@@admin_email)

  before(:each) do
    log_in_admin()
    visit 'manage_members'
  end

  after(:each) do
    log_out()
  end

  scenario 'shows header and subheaders' do
    expect(page).to have_content('Manage Members')
    expect(page).to have_content('New Users')
    expect(page).to have_content('Members')
  end

  scenario 'turns new user into member' do
    member_row = find(:css, '#new_user_row_2')
    member_email = UserHelpers.class_variable_get(:@@member_email)
    within(member_row) do
      expect(page).to have_content(member_email)
      click_button("Manage")
      click_link("Make Member")
    end
  end
end
