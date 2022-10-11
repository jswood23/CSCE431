# frozen_string_literal: true

class ExternalController < ApplicationController
  def about; end

  def contact; end

  def events
    #order events by date
    @events = Event.order('date ASC')
    @upcoming_events = Event.order('date ASC').where("date > ?", Time.now)
    @past_events = Event.order('date DESC').where("date < ?", Time.now)
  end

  def home; end
end
