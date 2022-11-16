# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('Visiting the home page', type: :feature) do
  it 'nav bar for non-user shows correct content' do
    visit '/home'

    # has main buttons
    expect(page).to(have_content('Home'))
    expect(page).to(have_content('About Us'))
    expect(page).to(have_content('Events'))
    expect(page).to(have_content('Contact Us'))

    # does not have dropdowns for members or admins
    expect(page).not_to(have_content('Member'))
    expect(page).not_to(have_content('Admin'))
  end

  it 'nav bar for user with no permissions shows correct content' do
    log_in_member(member: false)
    visit '/home'

    # has main buttons
    expect(page).to(have_content('Home'))
    expect(page).to(have_content('About Us'))
    expect(page).to(have_content('Events'))
    expect(page).to(have_content('Contact Us'))

    # does not have dropdowns for members or admins
    expect(page).not_to(have_content('Member'))
    expect(page).not_to(have_content('Admin'))

    log_out
  end

  it 'nav bar for member shows correct content' do
    log_in_member
    visit '/home'

    # has main buttons
    expect(page).to(have_content('Home'))
    expect(page).to(have_content('About Us'))
    expect(page).to(have_content('Events'))
    expect(page).to(have_content('Contact Us'))

    # has member dropdown
    expect(page).to(have_content('Member'))
    click_on 'Member'
    # expect(page).to(have_content('My Profile'))
    expect(page).to(have_content('Contact List'))
    expect(page).to(have_content('Attend an Event'))

    # does not have admin dropdown
    expect(page).not_to(have_content('Admin'))

    log_out
  end

  it 'nav bar for admin shows correct content' do
    log_in_admin
    visit '/home'

    # has main buttons
    expect(page).to(have_content('Home'))
    expect(page).to(have_content('About Us'))
    expect(page).to(have_content('Events'))
    expect(page).to(have_content('Contact Us'))

    # has member dropdown
    expect(page).to(have_content('Member'))
    click_on 'Member'
    # expect(page).to(have_content('My Profile'))
    expect(page).to(have_content('Contact List'))
    expect(page).to(have_content('Attend an Event'))

    # has admin dropdown
    expect(page).to(have_content('Admin'))
    click_on 'Admin'
    expect(page).to(have_content('Manage Events'))
    expect(page).to(have_content('Manage Members'))
    expect(page).to(have_content('Manage Pages'))

    # has user buttons
    find('#navbarProfileDropdown').click
    expect(page).to(have_content('Manage Account'))
    expect(page).to(have_content('Log out'))

    log_out
  end

  it 'attempt to access internal page without access' do
    visit '/attend'
    expect(page).to(have_content('The Maternal and Child Health Student Organization'))
    expect(page).to(have_content('You do not have permission to access this.'))
  end

  it 'attempt to access admin page without access' do
    visit '/manage_members'
    expect(page).to(have_content('The Maternal and Child Health Student Organization'))
    expect(page).to(have_content('You do not have permission to access this.'))
  end
end
