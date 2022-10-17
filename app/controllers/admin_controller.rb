# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :check_has_access

  def check_has_access
    return true if current_user&.admin

    redirect_to '/home'
    false
  end

  def manage_members
    # current_user.admin = true
    # current_user.save()
  end

  def manage_pages; end

  def manage_events; end
end
