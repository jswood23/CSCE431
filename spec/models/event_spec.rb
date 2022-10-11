require 'rails_helper'
require './spec/support/user_helpers'

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