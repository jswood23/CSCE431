class InternalController < ApplicationController
  before_action :check_has_member_access

  def attend
  end

  def members
  end

  def profile
  end

  # Controller actions (without pages)

  private

  def check_has_member_access
    if is_member
      return true
    end
    redirect_to '/home'
    return false
  end
end
