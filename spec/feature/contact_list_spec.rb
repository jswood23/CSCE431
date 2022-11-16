# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('Contact List', type: :feature) do
  describe 'view contacts' do
    it 'shows contact list' do

      admin_name = UserHelpers.class_variable_get(:@@admin_name)
      log_in_member
      visit '/internal_contact'
      expect(page).to(have_content('Member Contact Information'))
      member_table = find(:css, '#member-table')
      within(member_table) do
        expect(page).to(have_content(admin_name))
      end
      log_out
    end

    it 'search for admin name' do
      admin_name = UserHelpers.class_variable_get(:@@admin_name)
      log_in_member
      visit '/internal_contact'
      fill_in 'search', with: admin_name
      click_on 'Search'
      expect(page).to(have_content('Search Results'))
      member_table = find(:css, '#member-table')
      within(member_table) do
        expect(page).to(have_content(admin_name))
      end
      log_out
    end

    it 'search for invalid name' do
      log_in_member
      visit '/internal_contact'
      fill_in 'search', with: 'invalid name'
      click_on 'Search'
      expect(page).to(have_content('Search Results'))
      expect(page).to(have_content('No members found.'))
      log_out
    end

    it 'empty search input' do
      log_in_member
      visit '/internal_contact'
      fill_in 'search', with: ''
      click_on 'Search'
      expect(page).to(have_content('Member Contact Information'))
      expect(page).not_to(have_content('Search Results'))
      expect(page).not_to(have_content('No members found.'))
      log_out
    end
  end
end