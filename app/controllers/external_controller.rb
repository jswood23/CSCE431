# frozen_string_literal: true

class ExternalController < ApplicationController
  def about
    # @page = Page.where(page_name: 'about').order("created_at DESC").first
  end

  def contact
    # @page = Page.where(page_name: 'contact').order("created_at DESC").first
    @hrefs = { email: 'mailto:hannahbartosh@tamu.edu', facebook: 'https://www.facebook.com/MCHSOaggies/' }
  end

  def events
    # @page = Page.where(page_name: 'events').order("created_at DESC").first
  end

  def home
    # @page = Page.where(page_name: 'home').order("created_at DESC").first
  end
end
