# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('events/edit', type: :view) do
  before do
    @event = assign(:event, Event.create!(
                              event_name: 'MyString',
                              description: 'MyText',
                              passcode: 'MyString',
                              date: Time.zone.now,
                              points: 1
                            )
    )
  end

  it 'renders the edit event form' do
    render

    assert_select 'form[action=?][method=?]', event_path(@event), 'post' do
      assert_select 'input[name=?]', 'event[event_name]'

      assert_select 'textarea[name=?]', 'event[description]'

      assert_select 'input[name=?]', 'event[passcode]'

      assert_select 'input[name=?]', 'event[points]'
    end
  end
end
