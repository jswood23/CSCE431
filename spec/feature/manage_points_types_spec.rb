# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('manage points types', type: :feature) do
  it 'test points type actions' do
    starting_types = 3
    expect(PointsType.all.count).to(eq(starting_types))
    log_in_admin
    visit '/update_points'

    # new points type
    click_button('New Points Type')
    expect(PointsType.all.count).to(eq(starting_types + 1))

    # update points type
    new_type_row = find(:css, '#points_type_row_1')
    within(new_type_row) do
      fill_in 'name', with: 'Test Type'
      click_button('Update')
    end
    
    # delete points type
    within(new_type_row) do
      click_link('Remove')
    end
    expect(PointsType.all.count).to(eq(starting_types))

    log_out
  end
end