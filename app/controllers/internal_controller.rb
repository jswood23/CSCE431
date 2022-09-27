class InternalController < ApplicationController
  before_action :check_has_access

  def check_has_access
    if current_user
      return true
    end
    redirect_to '/home'
    return false
  end

  def attend
  end

  def members
  end

  def profile
  end
end
