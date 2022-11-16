# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('admin/manage_members.html.erb', type: :feature) do
  it 'shows header and subheaders' do
    log_in_admin
    visit 'manage_members'
    expect(page).to(have_content('Manage Members'))
    expect(page).to(have_content('New Users'))
    expect(page).to(have_content('Members'))
    expect(page).to(have_content('Alumni'))
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

    # turns member to alumni
    within(member_row) do
      expect(page).to(have_content(member_name))
      expect(page).to(have_content(member_email))
      expect(page).to(have_content('0'))
      click_button('Manage')
      click_link('Make Alumni')
    end
    assert User.find(2).alumni == true

    # turns alumni into member
    within(member_row) do
      expect(page).to(have_content(member_email))
      click_button('Manage')
      click_link('Remove Alumni Status')
    end
    assert User.find(2).alumni == false

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
    assert User.all.length == 2

    log_out
  end

  it 'check error messages for manage members nonexistant user' do
    log_in_admin

    # attempt to make nonexistant user a member
    visit '/make_user_member/23'
    expect(page).to(have_content('Error: user 23 does not exist.'))

    # attempt to make nonexistant user an admin
    visit '/make_user_admin/23'
    expect(page).to(have_content('Error: user 23 does not exist.'))

    # attempt to remove member permissions from a nonexistant user
    visit '/remove_user_member/23'
    expect(page).to(have_content('Error: user 23 does not exist.'))

    # attempt to make nonexistant user an alumni
    visit '/make_user_alumni/23'
    expect(page).to(have_content('Error: user 23 does not exist.'))

    # attempt to delete nonexistant user
    visit '/delete_user/23'
    expect(page).to(have_content('Error: user 23 does not exist.'))

    log_out
  end

  it 'check error messages for manage members unavailable action' do
    log_in_admin
    visit '/home'

    # attempt to make user an admin who is already an admin
    visit '/make_user_admin/1'
    expect(page).to(have_content('Error: user Administrator is already an admin.'))

    # attempt to make user not a member who is already not a member
    visit '/remove_user_member/3'
    expect(page).to(have_content('Error: user Alumni is already not a member.'))

    # attempt to delete admin
    visit '/delete_user/1'
    expect(page).to(have_content("Error: please remove user's permissions before deletion."))

    log_out
  end
end
