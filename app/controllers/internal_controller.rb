# frozen_string_literal: true

class InternalController < ApplicationController
  before_action :check_has_member_access

  def attend; end

  def members; end

  def profile; end

  # Controller actions (without pages)

  private

  def check_has_member_access
    return true if is_member

    redirect_to('/home')
    false
  end
end
