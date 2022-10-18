# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('external/home.html.erb', type: :feature) do
  before do
    visit '/home'
  end

  it 'shows introduction content' do
    expect(page).to(have_content('Welcome to the Maternal and Child Health Student Organization'))
  end
end
