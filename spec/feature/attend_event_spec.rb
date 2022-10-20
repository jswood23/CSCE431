# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('Event Attendance', type: :feature) do
  describe 'Attendance record reflects attendance' do
    it 'Record initially empty' do
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
  end
end