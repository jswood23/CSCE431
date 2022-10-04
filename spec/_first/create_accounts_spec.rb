# frozen_string_literal: true

require 'rails_helper'
require './spec/support/user_helpers'

RSpec.describe('Creating accounts', type: :feature) do
  before(:all) do
    create_accounts
  end

  it 'asserts that both admin account and member account exists' do
    log_in_admin
    log_out
    log_in_member
    log_out
  end
end
