# frozen_string_literal: true

require 'rails_helper'
require './spec/support/entity_helpers'

RSpec.describe('Creating accounts and events', type: :feature) do
  # rubocop:disable RSpec/BeforeAfterAll
  before(:all) do
    ActiveRecord::Base.connection.execute('TRUNCATE users RESTART IDENTITY;')
    ActiveRecord::Base.connection.execute('TRUNCATE events RESTART IDENTITY;')
    ActiveRecord::Base.connection.execute('TRUNCATE attendance_records RESTART IDENTITY;')
    create_accounts
    create_events
  end
  # rubocop:enable RSpec/BeforeAfterAll

  it 'asserts that both admin account and member account exists' do
    log_in_admin
    log_out
    log_in_member
    log_out
    log_in_alumni
    log_out
  end
end
