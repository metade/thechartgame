# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_thechartgame_session',
  :secret      => '3f64222436b93c91cb4aa1e39e9d5bb2027c3ea4bbf71a8939c19b4091975587f108843f633df64d5794cecf2d39b98fbdae49134b690c2eb4d20d4e491d38a3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
