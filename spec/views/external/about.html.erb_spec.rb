# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'
require 'pp'


RSpec.describe('external/about.html.erb', type: :feature) do
  before do
    visit '/about'
  end

  it 'should show main header' do
    expect(page).to(have_content('About Us'))
  end

  it 'should show correct subheaders' do
    about_page = Page.where(page_name: "about").pluck(:page_data)
    about_page.each do |attr|
        json = JSON.parse(attr)
        json.each do |name, desc|
            expect(page).to(have_content(name))
        end
    end
  end

  it 'should show correct descriptions' do
    about_page = Page.where(page_name: "about").pluck(:page_data)
    about_page.each do |attr|
        json = JSON.parse(attr)
        json.each do |name, desc|
            expect(page).to(have_content(desc))
        end
    end
  end

end
