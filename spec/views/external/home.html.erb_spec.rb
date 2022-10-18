# frozen_string_literal: true

require 'rails_helper'
RSpec.describe('external/home.html.erb', type: :view) do
  it 'shows introduction content' do
    visit '/home'
    expect(page).to(have_content('Welcome to the Maternal and Child Health Student Organization'))
  end
end
