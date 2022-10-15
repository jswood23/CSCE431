# frozen_string_literal: true

class InternalController < ApplicationController
  before_action :check_has_member_access

  def attend
    # order events by date
    @events_today = Event.where(date: Time.zone.today.all_day)
    @upcoming_events = Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day)
    @past_events = Event.order('date DESC').where('date < ?', Time.zone.now.beginning_of_day)
  end

  def members; end

  def profile; end

  # Controller actions (without pages)

  private

  def check_has_member_access
    return true if member?

    redirect_to('/home')
    false
  end
end
