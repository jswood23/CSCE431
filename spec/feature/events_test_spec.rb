# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('Creating an event', type: :feature) do
  describe 'Creating an event' do
    it 'valid inputs' do
      log_in_admin
      visit new_event_path
      current_time = DateTime.now
      fill_in 'Event name', with: 'Test Event'
      fill_in 'Description', with: 'This is a test event'
      fill_in 'Passcode', with: 'test'
      fill_in 'Date', with: current_time
      fill_in 'Points', with: 1
      click_on 'Create Event'
      visit events_path
      expect(page).to(have_content('Test Event'))
      expect(page).to(have_content(current_time.year))
      expect(page).to(have_content(current_time.month))
      expect(page).to(have_content('This is a test event'))
      expect(page).to(have_content('Password: test'))
      expect(page).to(have_content('Edit'))
      expect(Event.count).to(eq(2))
      log_out
    end

    it 'invalid name input' do
      log_in_admin
      visit new_event_path
      fill_in 'Description', with: 'This is a test event'
      fill_in 'Passcode', with: 'test'
      fill_in 'Date', with: DateTime.now
      fill_in 'Points', with: 1
      click_on 'Create Event'
      expect(page).to(have_content('Event name can\'t be blank'))
      expect(Event.count).to(eq(1))
      log_out
    end

    it 'invalid description input' do
      log_in_admin
      visit new_event_path
      fill_in 'Event name', with: 'Test Event'
      fill_in 'Passcode', with: 'test'
      fill_in 'Date', with: DateTime.now
      fill_in 'Points', with: 1
      click_on 'Create Event'
      expect(page).to(have_content('Description can\'t be blank'))
      expect(Event.count).to(eq(1))
      log_out
    end

    it 'invalid passcode input' do
      log_in_admin
      visit new_event_path
      fill_in 'Event name', with: 'Test Event'
      fill_in 'Description', with: 'This is a test event'
      fill_in 'Date', with: DateTime.now
      fill_in 'Points', with: 1
      click_on 'Create Event'
      expect(page).to(have_content('Passcode can\'t be blank'))
      expect(Event.count).to(eq(1))
      log_out
    end

    it 'invalid points input' do
      log_in_admin
      visit new_event_path
      fill_in 'Event name', with: 'Test Event'
      fill_in 'Description', with: 'This is a test event'
      fill_in 'Passcode', with: 'test'
      fill_in 'Date', with: DateTime.now
      fill_in 'Points', with: ''
      click_on 'Create Event'
      expect(page).to(have_content('Points can\'t be blank'))
      expect(Event.count).to(eq(1))
      log_out
    end
  end

  describe 'Editing an event' do
    before do
      Event.create!(event_name: 'Test Event', description: 'This is a test event',
                    passcode: 'test', date: Time.zone.now, points: 1
      )
    end

    it 'valid updates' do
      log_in_admin
      visit events_path
      expect(Event.count).to(eq(2))
      this_event_id = Event.where(event_name: 'Test Event').first.id
      this_event_card = find(:css, "#event_#{this_event_id}")
      within this_event_card do
        click_on 'Edit'
      end
      updated_time = DateTime.now + 1.year
      fill_in 'Event name', with: 'New Test Event'
      fill_in 'Description', with: 'This is a new test event'
      fill_in 'Passcode', with: 'newtest'
      fill_in 'Date', with: updated_time
      fill_in 'Points', with: 2
      click_on 'Update Event'
      visit events_path
      expect(page).to(have_content('New Test Event'))
      expect(page).to(have_content(updated_time.year))
      expect(page).to(have_content(updated_time.month))
      expect(page).to(have_content('This is a new test event'))
      expect(page).to(have_content('Password: newtest'))
      expect(page).to(have_content('Edit'))
      log_out
    end

    it 'invalid name updates' do
      log_in_admin
      visit events_path
      expect(Event.count).to(eq(2))
      this_event_id = Event.where(event_name: 'Test Event').first.id
      this_event_card = find(:css, "#event_#{this_event_id}")
      within this_event_card do
        click_on 'Edit'
      end
      fill_in 'Event name', with: ''
      click_on 'Update Event'
      expect(page).to(have_content('Event name can\'t be blank'))
      expect(Event.count).to(eq(2))
      log_out
    end

    it 'invalid description updates' do
      log_in_admin
      visit events_path
      expect(Event.count).to(eq(2))
      this_event_id = Event.where(event_name: 'Test Event').first.id
      this_event_card = find(:css, "#event_#{this_event_id}")
      within this_event_card do
        click_on 'Edit'
      end
      fill_in 'Description', with: ''
      click_on 'Update Event'
      expect(page).to(have_content('Description can\'t be blank'))
      log_out
    end

    it 'invalid passcode updates' do
      log_in_admin
      visit events_path
      expect(Event.count).to(eq(2))
      this_event_id = Event.where(event_name: 'Test Event').first.id
      this_event_card = find(:css, "#event_#{this_event_id}")
      within this_event_card do
        click_on 'Edit'
      end
      fill_in 'Passcode', with: ''
      click_on 'Update Event'
      expect(page).to(have_content('Passcode can\'t be blank'))
      log_out
    end

    it 'invalid points updates' do
      log_in_admin
      visit events_path
      expect(Event.count).to(eq(2))
      this_event_id = Event.where(event_name: 'Test Event').first.id
      this_event_card = find(:css, "#event_#{this_event_id}")
      within this_event_card do
        click_on 'Edit'
      end
      fill_in 'Points', with: ''
      click_on 'Update Event'
      expect(page).to(have_content('Points can\'t be blank'))
      log_out
    end
  end
  # describe 'Deleting an event' do
  #    Capybara.current_driver = :webkit
  #    let!(:event) { Event.create(event_name: 'Test Event', description: 'This is a test event',
  #            passcode: 'test', date: Time.now, points: 1)}
  #
  #    scenario 'valid delete' do
  #        log_in_admin
  #        visit events_path
  #        dismiss_confirm do
  #            click_on 'Remove'
  #        end
  #        expect(page).to have_content('Event was successfully destroyed.')
  #        expect(Event.count).to eq(0)
  #        log_out
  #    end
  # end
end
