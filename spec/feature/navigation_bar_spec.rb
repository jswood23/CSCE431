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
    expect(page).not_to(have_content('MCHSO Member'))
    expect(page).not_to(have_content('MCHSO Admin'))

    # has login buttons
    expect(page).to(have_content('Login'))
    expect(page).to(have_content('Create Account'))
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
    expect(page).not_to(have_content('MCHSO Member'))
    expect(page).not_to(have_content('MCHSO Admin'))

    # has user buttons
    expect(page).to(have_content('Edit Account'))
    expect(page).to(have_content('Logout'))

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
    expect(page).to(have_content('MCHSO Member'))
    click_on 'MCHSO Member'
    # expect(page).to(have_content('My Profile'))
    expect(page).to(have_content('Member List'))
    expect(page).to(have_content('Attend an Event'))

    # does not have admin dropdown
    expect(page).not_to(have_content('MCHSO Admin'))

    # has user buttons
    expect(page).to(have_content('Edit Account'))
    expect(page).to(have_content('Logout'))

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
    expect(page).to(have_content('MCHSO Member'))
    click_on 'MCHSO Member'
    # expect(page).to(have_content('My Profile'))
    expect(page).to(have_content('Member List'))
    expect(page).to(have_content('Attend an Event'))

    # has admin dropdown
    expect(page).to(have_content('MCHSO Admin'))
    click_on 'MCHSO Admin'
    expect(page).to(have_content('Manage Events'))
    expect(page).to(have_content('Manage Members'))
    expect(page).to(have_content('Manage Pages'))

    # has user buttons
    expect(page).to(have_content('Edit Account'))
    expect(page).to(have_content('Logout'))

    log_out
  end
end
