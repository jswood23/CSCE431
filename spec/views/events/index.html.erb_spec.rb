require 'rails_helper'

RSpec.describe "Visiting events page", type: :feature do
  scenario 'events page has full content' do
    visit events_path
    # event attributes
    # expect(page).to have_content('Event Name')
    # expect(page).to have_content('Description')
    # expect(page).to have_content('Date')
    # expect(page).to have_content('Points')

    expect(page).not_to have_content('Create New Event')
    expect(page).not_to have_content('Passcode')
    
  end
end
