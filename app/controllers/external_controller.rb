# frozen_string_literal: true

class ExternalController < ApplicationController
  def about; end

  def contact
    @hrefs = { email: 'mailto:hannahbartosh@tamu.edu', facebook: 'https://www.facebook.com/MCHSOaggies/' }
  end

  def events
    # order events by date
    @events_today = Event.where(date: Time.zone.today.all_day)
    @upcoming_events = Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day)
  end

  def home; end
end
