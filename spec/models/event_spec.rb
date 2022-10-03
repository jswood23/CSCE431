require 'rails_helper'

RSpec.describe Event, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject do 
    described_class.new(event_name: 'Meeting', description: 'Meeting for organization', date:'2022-10-01', 
                        points: 1, passcode: '123abc')
  end

  it 'is valid with all valid attributes' do
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

  it 'is not valid without a date' do
    subject.date = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without points' do
    subject.points = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without passcode' do
    subject.passcode = nil
    expect(subject).not_to be_valid
  end
end
