require 'rails_helper'
require './spec/support/user_helpers'

RSpec.describe('Creating accounts', type: :feature) do
  # rubocop:disable RSpec/BeforeAfterAll
  before(:all) do
    ActiveRecord::Base.connection.execute('TRUNCATE users RESTART IDENTITY;')
    create_accounts
  end
  # rubocop:enable RSpec/BeforeAfterAll

  it 'asserts that both admin account and member account exists' do
    log_in_admin
    log_out
    log_in_member
    log_out
  end
end
