require 'rails_helper'
require './spec/support/user_helpers'

RSpec.describe 'Creating an event', type: :feature do
    scenario 'valid inputs' do
        log_in_admin
        visit new_event_path
        fill_in 'Event name', with: 'Test Event'
        fill_in 'Description', with: 'This is a test event'
        fill_in 'Passcode', with: 'test'
        select '2022', from: 'event[date(1i)]'
        select 'October', from: 'event[date(2i)]'
        select '11', from: 'event[date(3i)]'
        select '04', from: 'event[date(4i)]'
        select '00', from: 'event[date(5i)]'
        fill_in 'Points', with: 1
        click_on 'Create Event'
        visit events_path
        expect(page).to have_content('Test Event')
        expect(page).to have_content('This is a test event')
        expect(page).to have_content('test')
        expect(page).to have_content('2022-10-11')
        expect(page).to have_content('04:00:00 UTC')
        expect(page).to have_content('1')
        expect(Event.count).to eq(1)
        log_out
    end
    scenario 'invalid name input' do
        log_in_admin
        visit new_event_path
        fill_in 'Description', with: 'This is a test event'
        fill_in 'Passcode', with: 'test'
        select '2022', from: 'event[date(1i)]'
        select 'October', from: 'event[date(2i)]'
        select '11', from: 'event[date(3i)]'
        select '04', from: 'event[date(4i)]'
        select '00', from: 'event[date(5i)]'
        fill_in 'Points', with: 1
        click_on 'Create Event'
        expect(page).to have_content('Event name can\'t be blank')
        expect(Event.count).to eq(0)
        log_out
    end
    scenario 'invalid description input' do
        log_in_admin
        visit new_event_path
        fill_in 'Event name', with: 'Test Event'
        fill_in 'Passcode', with: 'test'
        select '2022', from: 'event[date(1i)]'
        select 'October', from: 'event[date(2i)]'
        select '11', from: 'event[date(3i)]'
        select '04', from: 'event[date(4i)]'
        select '00', from: 'event[date(5i)]'
        fill_in 'Points', with: 1
        click_on 'Create Event'
        expect(page).to have_content('Description can\'t be blank')
        expect(Event.count).to eq(0)
        log_out
    end
    scenario 'invalid passcode input' do
        log_in_admin
        visit new_event_path
        fill_in 'Event name', with: 'Test Event'
        fill_in 'Description', with: 'This is a test event'
        select '2022', from: 'event[date(1i)]'
        select 'October', from: 'event[date(2i)]'
        select '11', from: 'event[date(3i)]'
        select '04', from: 'event[date(4i)]'
        select '00', from: 'event[date(5i)]'
        fill_in 'Points', with: 1
        click_on 'Create Event'
        expect(page).to have_content('Passcode can\'t be blank')
        expect(Event.count).to eq(0)
        log_out
    end
    scenario 'invalid points input' do
        log_in_admin
        visit new_event_path
        fill_in 'Event name', with: 'Test Event'
        fill_in 'Description', with: 'This is a test event'
        fill_in 'Passcode', with: 'test'
        select '2022', from: 'event[date(1i)]'
        select 'October', from: 'event[date(2i)]'
        select '11', from: 'event[date(3i)]'
        select '04', from: 'event[date(4i)]'
        select '00', from: 'event[date(5i)]'
        click_on 'Create Event'
        expect(page).to have_content('Points can\'t be blank')
        expect(Event.count).to eq(0)
        log_out
    end
end

RSpec.describe 'Editing an event', type: :feature do
    let!(:event) { Event.create(event_name: 'Test Event', description: 'This is a test event', 
            passcode: 'test', date: Time.now, points: 1)}
    scenario 'valid updates' do
        log_in_admin
        visit events_path
        click_on 'Edit'
        fill_in 'Event name', with: 'New Test Event'
        fill_in 'Description', with: 'This is a new test event'
        fill_in 'Passcode', with: 'newtest'
        select '2023', from: 'event[date(1i)]'
        select 'October', from: 'event[date(2i)]'
        select '11', from: 'event[date(3i)]'
        select '05', from: 'event[date(4i)]'
        select '10', from: 'event[date(5i)]'
        fill_in 'Points', with: 2
        click_on 'Update Event'
        visit events_path
        expect(page).to have_content('New Test Event')
        expect(page).to have_content('This is a new test event')
        expect(page).to have_content('newtest')
        expect(page).to have_content('2023-10-11')
        expect(page).to have_content('05:10:00 UTC')
        expect(page).to have_content('2')
        expect(Event.count).to eq(1)
        log_out
    end

    scenario 'invalid name updates' do
        log_in_admin
        visit events_path
        click_on 'Edit'
        fill_in 'Event name', with: ''
        click_on 'Update Event'
        expect(page).to have_content('Event name can\'t be blank')
        expect(Event.count).to eq(1)
        log_out
    end
    scenario 'invalid description updates' do
        log_in_admin
        visit events_path
        click_on 'Edit'
        fill_in 'Description', with: ''
        click_on 'Update Event'
        expect(page).to have_content('Description can\'t be blank')
        expect(Event.count).to eq(1)
        log_out
    end
    scenario 'invalid passcode updates' do
        log_in_admin
        visit events_path
        click_on 'Edit'
        fill_in 'Passcode', with: ''
        click_on 'Update Event'
        expect(page).to have_content('Passcode can\'t be blank')
        expect(Event.count).to eq(1)
        log_out
    end
    scenario 'invalid points updates' do
        log_in_admin
        visit events_path
        click_on 'Edit'
        fill_in 'Points', with: ''
        click_on 'Update Event'
        expect(page).to have_content('Points can\'t be blank')
        expect(Event.count).to eq(1)
        log_out
    end
end

#RSpec.describe 'Deleting an event', type: :feature do
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
#end

RSpec.describe Event, type: :model do
    subject do
        described_class.new(event_name: 'Test Event', description: 'This is a test event', 
            passcode: 'test', date: Time.now, points: 1)
    end

    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end

    it 'is not valid without a name' do
        subject.event_name = nil
        expect(subject).not_to be_valid
    end
    it 'is not valid without a description' do
        subject.description = nil
        expect(subject).not_to be_valid
    end
    it 'is not valid without a passcode' do
        subject.passcode = nil
        expect(subject).not_to be_valid
    end
    it 'is not valid without a date' do
        subject.date = nil
        expect(subject).not_to be_valid
    end
    it 'is not valid without a points' do
        subject.points = nil
        expect(subject).not_to be_valid
    end
end