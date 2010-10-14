# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if defined?(EventCalendar::Application)
  EventCalendar::Application.config.secret_token = '495e5075c990834c82f6826524af9f786bfc8a0555c8272237ad6de534155509676bd0602c331c263f4d75ce7f69a336fb3569e789c30b5fd9269ceb25be50f5'
end
