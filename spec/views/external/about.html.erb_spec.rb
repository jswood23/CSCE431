# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('external/about.html.erb', type: :feature) do
  before do
    visit '/about'
  end

  it 'shows main header' do
    expect(page).to(have_content('About Us'))
  end

  # all subheaders in database exist and match those shown on the page
  it 'shows correct subheaders' do
    about_page = Page.where(page_name: 'about').pluck(:page_data)
    about_page.each do |attr|
      json = JSON.parse(attr)
      json.each do |name, _desc|
        expect(page).to(have_content(name))
      end
    end
  end

  # all descriptions in database exist and match those shown on the page
  it 'shows correct descriptions' do
    about_page = Page.where(page_name: 'about').pluck(:page_data)
    about_page.each do |attr|
      json = JSON.parse(attr)
      json.each do |_name, desc|
        expect(page).to(have_content(desc))
      end
    end
  end
end
