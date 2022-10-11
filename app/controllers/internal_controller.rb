# frozen_string_literal: true

class InternalController < ApplicationController
  before_action :check_has_member_access

  def attend
    #order events by date
    @events = Event.order('date ASC')
    @upcoming_events = Event.order('date ASC').where("date > ?", Time.now)
    @past_events = Event.order('date DESC').where("date < ?", Time.now)
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
