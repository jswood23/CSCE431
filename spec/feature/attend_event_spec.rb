# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('Event Attendance', type: :feature) do
  describe 'Attendance record reflects attendance' do
    it 'record initially empty' do
      expect(AttendanceRecord.where(event_id: 1).count).to(eq(0))
      log_in_admin
      visit events_path
      this_event_card = find(:css, '#event_1')
      within(this_event_card) do
        click_on 'Show Attendance'
      end
      expect(page).to(have_content('No one has attended this event yet.'))
      log_out
    end

    it 'user attends event' do
      log_in_admin
      visit '/attend'
      this_event_card = find(:css, '#event_1')
      this_event_passcode = UserHelpers.class_variable_get(:@@event_passcode)
      within(this_event_card) do
        fill_in 'Password', with: this_event_passcode
        click_on 'I\'m here!'
      end
      expect(AttendanceRecord.where(event_id: 1).count).to(eq(1))
      visit events_path
      this_event_card = find(:css, '#event_1')
      within(this_event_card) do
        click_on 'Show Attendance'
      end
      admin_name = UserHelpers.class_variable_get(:@@admin_name)
      this_row = find(:css, '#attendance_row_1')
      within(this_row) do
        expect(page).not_to(have_content('No one has attended this event yet.'))
        expect(page).to(have_content(admin_name))
      end
      log_out
    end
  end
end