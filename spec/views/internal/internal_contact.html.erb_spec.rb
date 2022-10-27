# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('internal/internal_contact.html.erb', type: :feature) do
  it 'shows header' do
    log_in_member
    visit 'internal_contact'
    expect(page).to(have_content('Members Contact Information'))
  end
end
