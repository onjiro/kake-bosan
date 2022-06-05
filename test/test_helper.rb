ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  load "#{Rails.root}/db/seeds.rb"

  private

  def sign_in(user = "user", email = "")
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:development] = OmniAuth::AuthHash.new
    {
      provider: "development",
      uid: "test_mock_user",
      info: {
        name: user,
        email: email,
      },
    }
    post "/auth/developer"
    follow_redirect!

    @current_user = User.find(session[:user_id])
  end

  def sign_out()
    get "/sessions/destroy"
  end
end
