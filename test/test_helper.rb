ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "capybara/rails"

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 20

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  load "#{Rails.root}/db/seeds.rb"

  private

  def sign_in(user = "user", email = "")
    OmniAuth.config.mock_auth[:development] = OmniAuth::AuthHash.new
    {
      provider: "development",
      uid: "test_mock_user",
      info: {
        name: user,
        email: email,
      },
    }
    visit "/auth/developer"
  end

  def sign_out()
    visit "/sessions/destroy"
  end
end
