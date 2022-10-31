# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('events/show', type: :view) do
  before do
    without_partial_double_verification do
      allow(view).to(receive(:get_points_type).and_return('Member'))
    end
    @event = assign(:event, Event.create!(
                              event_name: 'Event Name',
                              description: 'MyText',
                              passcode: 'Passcode',
                              date: Time.zone.now,
                              points: 2,
                              points_type_id: 1
                            )
    )
    @points_types = PointsType.all.order('id ASC')
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to(match(/Event Name/))
    expect(rendered).to(match(/MyText/))
    expect(rendered).to(match(/Passcode/))
    expect(rendered).to(match(/Date/))
    expect(rendered).to(match(/2/))
  end
end
