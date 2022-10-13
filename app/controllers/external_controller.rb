# frozen_string_literal: true

class ExternalController < ApplicationController
  def about; end

  def contact; end

  def events
    # order events by date
    @events = Event.order('date ASC')
    @events_today = Event.where(date: Time.zone.today.all_day)
    @upcoming_events = Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day)
    @past_events = Event.order('date DESC').where('date < ?', Time.zone.now.beginning_of_day)
  end

  def home; end
end
