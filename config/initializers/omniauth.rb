Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development? || Rails.env.test?
  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
end
