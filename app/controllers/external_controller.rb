# frozen_string_literal: true

class ExternalController < ApplicationController
  def about
    @page = Page.order('updated_at ASC').where(page_name: 'about').first
  end

  def contact
    @hrefs = {
      email: 'mailto:hannahbartosh@tamu.edu',
      facebook: 'https://www.facebook.com/MCHSOaggies/',
      store: 'https://tamu.estore.flywire.com/products?storeCatalog=7302',
      instagram: 'https://www.instagram.com/mchsoaggies/?hl=en'
    }
  end

  def events
    # order events by date
    @events_today = Event.where(date: Time.zone.today.all_day)
    @upcoming_events = Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day)
  end

  def home; end
end
