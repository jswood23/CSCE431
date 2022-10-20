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

    it 'check that user attended event' do
      attend_event_admin
      log_in_admin
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
        expect(AttendanceRecord.where(event_id: 1).count).to(eq(1))
      end
      log_out
    end

    it 'remove user from event attendance' do
      attend_event_admin
      log_in_admin
      expect(AttendanceRecord.where(event_id: 1).count).to(eq(1))
      visit events_path
      this_event_card = find(:css, '#event_1')
      within(this_event_card) do
        click_on 'Show Attendance'
      end
      admin_name = UserHelpers.class_variable_get(:@@admin_name)
      this_row = find(:css, '#attendance_row_1')
      within(this_row) do
        click_on 'Remove'
      end
      expect(page).to(have_content("Member #{admin_name} has been successfully removed from event."))
      expect(page).to(have_content('No one has attended this event yet.'))
      expect(AttendanceRecord.where(event_id: 1).count).to(eq(0))
      log_out
    end

    it 'view and change user points' do
      attend_event_admin
      log_in_admin
      visit '/manage_members'
      admin_row = find(:css, '#member_row_1')
      within(admin_row) do
        expect(page).to(have_content('1'))
        click_on '1'
      end
      admin_name = UserHelpers.class_variable_get(:@@admin_name)
      event_name = UserHelpers.class_variable_get(:@@event_name)
      expect(page).to(have_content("Showing attendance for #{admin_name}"))
      expect(page).to(have_content(event_name))
      fill_in 'points', with: '2'
      click_on 'Save'
      click_on 'Back'
      admin_row = find(:css, '#member_row_1')
      within(admin_row) do
        expect(page).to(have_content('2'))
      end
      log_out
    end
  end
end
