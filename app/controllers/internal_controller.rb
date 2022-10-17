# frozen_string_literal: true

class InternalController < ApplicationController
  before_action :check_has_access

  def check_has_access
    return true if current_user

    redirect_to '/home'
    false
  end

  def attend
    # current_user.admin = true
    # current_user.save()
  end

  def members; end

  def profile; end
end
