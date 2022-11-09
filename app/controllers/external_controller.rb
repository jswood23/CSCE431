# frozen_string_literal: true

class ExternalController < ApplicationController
  def about
    @page = JSON.parse(Page.order('updated_at DESC').where(page_name: 'about').first[:page_data])
  end

  def contact
    @page = JSON.parse(Page.order('updated_at DESC').where(page_name: 'contact').first[:page_data])
  end

  def events
    # order events by date
    @events_today = Event.where(date: Time.zone.today.all_day).order('date ASC')
    @upcoming_events = Event.where('date > ?', Time.zone.now.end_of_day).order('date ASC')
  end

  def home
    @page = JSON.parse(Page.order('updated_at DESC').where(page_name: 'home').first[:page_data])
  end

  def faq; end
end
