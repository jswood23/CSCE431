require 'rails_helper'

RSpec.describe "admin/manage_events.html.erb", type: :feature do
  scenario 'shows header content' do
    visit '/manage_events'
    expect(page).to have_content('Manage Events')
  end
end
