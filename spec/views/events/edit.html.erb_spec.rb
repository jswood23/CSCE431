# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('events/edit', type: :view) do
  before do
    without_partial_double_verification do
      allow(view).to(receive(:get_points_type).and_return('Member'))
    end
    @event = assign(:event, Event.create!(
                              event_name: 'MyString',
                              description: 'MyText',
                              passcode: 'MyString',
                              date: Time.zone.now,
                              points: 1,
                              points_type_id: 1
                            )
    )
    @points_types = PointsType.all.order('id ASC')
  end

  it 'renders the edit event form' do
    render

    assert_select 'form[action=?][method=?]', event_path(Event.last.id.to_s), 'post' do
      assert_select 'input[name=?]', 'event[event_name]'

      assert_select 'textarea[name=?]', 'event[description]'

      assert_select 'input[name=?]', 'event[passcode]'
    end
  end
end
