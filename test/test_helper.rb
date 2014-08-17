ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

Capybara.default_driver = :selenium
Capybara.default_wait_time = 10

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Make sure not rollback on finish every case
  # Change from webkit will be commited in any case.
  # So, we clean table with database rewinder.
  self.use_transactional_fixtures = false
  load "#{Rails.root}/db/seeds.rb"

  def teardown_with_global
    teardown_without_global
    DatabaseRewinder.clean_with :truncate, except:
      [
       'accounting_sides',
       'accounting_types',
      ]
  end
  alias_method_chain :teardown, :global

  private
  def sign_in(user = 'user', email = '')
    OmniAuth.config.mock_auth[:development] = OmniAuth::AuthHash.new
    {
      provider: 'development',
      uid: 'test_mock_user',
      info: {
        name:  user,
        email: email
      }
    }
    visit '/auth/developer'
  end

  def sign_out()
    visit '/sessions/destroy'
  end
end
