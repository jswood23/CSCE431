# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('events/new', type: :view) do
  before do
    without_partial_double_verification do
      allow(view).to(receive(:get_points_type).and_return('Member'))
    end
    assign(:event, Event.new(
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

  it 'renders new event form' do
    render

    assert_select 'form[action=?][method=?]', events_path, 'post' do
      assert_select 'input[name=?]', 'event[event_name]'

      assert_select 'textarea[name=?]', 'event[description]'

      assert_select 'input[name=?]', 'event[passcode]'
    end
  end
end
