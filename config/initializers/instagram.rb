require "instagram"

CALLBACK_URL = "http://localhost:3000/oauth/callback"

Instagram.configure do |config|
  config.client_id = "8a325a9ed59e402bbd792f732962b81c"
  config.client_secret = "f0256e93e19b4256a48bfc723c62ad51"
  # config.access_token = "31203422.8a325a9.af461ea76249433ba9981788002b25a7"
end
