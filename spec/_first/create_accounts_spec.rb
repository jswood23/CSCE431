# frozen_string_literal: true

require 'rails_helper'
require './spec/support/user_helpers'

RSpec.describe('Creating accounts', type: :feature) do
  it 'asserts that both admin account and member account exists' do
    create_accounts
    log_in_admin
    log_out
    log_in_member
    log_out
  end
end
