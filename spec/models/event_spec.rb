# frozen_string_literal: true

require 'rails_helper'
require './spec/support/user_helpers'

RSpec.describe(Event, type: :model) do
  subject(:event) do
    described_class.new(event_name: 'Test Event', description: 'This is a test event',
                        passcode: 'test', date: Time.zone.now, points: 1
    )
  end

  it 'is valid with valid attributes' do
    expect(event).to(be_valid)
  end

  it 'is not valid without a name' do
    event.event_name = nil
    expect(event).not_to(be_valid)
  end

  it 'is not valid without a description' do
    event.description = nil
    expect(event).not_to(be_valid)
  end

  it 'is not valid without a passcode' do
    event.passcode = nil
    expect(event).not_to(be_valid)
  end

  it 'is not valid without a date' do
    event.date = nil
    expect(event).not_to(be_valid)
  end

  it 'is not valid without a points' do
    event.points = nil
    expect(event).not_to(be_valid)
  end
end
