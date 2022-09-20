require 'rails_helper'

RSpec.describe "admin/manage_members.html.erb", type: :feature do
  scenario 'shows header content' do
    visit '/manage_members'
    expect(page).to have_content('Manage Members')
  end
end
