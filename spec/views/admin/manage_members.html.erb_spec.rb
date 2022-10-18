# frozen_string_literal: true

require 'rails_helper'
require './spec/support/user_helpers'

RSpec.describe('admin/manage_members.html.erb', type: :feature) do
  it 'shows header and subheaders' do
    log_in_admin
    visit 'manage_members'
    expect(page).to(have_content('Manage Members'))
    expect(page).to(have_content('New Users'))
    expect(page).to(have_content('Members'))
    log_out
  end

  it 'turns new user into member' do
    log_in_admin
    visit 'manage_members'

    # new user shows up
    expect(page).not_to(have_content('No new users.'))

    # turn new user into member
    member_email = UserHelpers.class_variable_get(:@@member_email)
    member_name = UserHelpers.class_variable_get(:@@member_name)

    member_row = find(:css, '#new_user_row_2')
    within(member_row) do
      expect(page).to(have_content(member_email))
      click_button('Manage')
      click_link('Make Member')
    end
    assert User.find(2).member == true
    expect(page).to(have_content('No new users.'))

    # turns member into admin
    member_row = find(:css, '#member_row_2')
    within(member_row) do
      expect(page).to(have_content(member_name))
      expect(page).to(have_content(member_email))
      expect(page).to(have_content('0'))
      click_button('Manage')
      click_link('Make Admin')
    end
    assert User.find(2).admin == true

    # turns admin into member
    within(member_row) do
      expect(page).to(have_content(member_email))
      click_button('Manage')
      click_link('Remove Admin Status')
    end
    assert User.find(2).admin == false

    # turns member into user
    within(member_row) do
      expect(page).to(have_content(member_email))
      click_button('Manage')
      click_link('Remove Member Status')
    end
    assert User.find(2).member == false
    expect(page).not_to(have_content('No new users.'))

    # deletes user
    member_row = find(:css, '#new_user_row_2')
    member_email = UserHelpers.class_variable_get(:@@member_email)
    within(member_row) do
      expect(page).to(have_content(member_email))
      click_button('Manage')
      click_link('Delete User')
    end
    expect(page).to(have_content('No new users.'))
    assert User.all.length == 1

    log_out
  end
end
