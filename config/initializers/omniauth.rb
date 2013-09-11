Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter,
  Settings.OmniAuth.twitter.consumer_key,
  Settings.OmniAuth.twitter.consumer_secret,
  display: 'popup'
end
