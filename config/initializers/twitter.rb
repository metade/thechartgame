twitter_config_path = File.join(RAILS_ROOT, 'config', 'twitter.yml')
if File.exist?(twitter_config_path)
  twitter_config = YAML.load(File.read(twitter_config_path))
  TWITTER_USERNAME = twitter_config[:username]
  TWITTER_PASSWORD = twitter_config[:password]
else
  TWITTER_USERNAME = ENV['TWITTER_USERNAME']
  TWITTER_PASSWORD = ENV['TWITTER_PASSWORD']
end
TWITTER_AUTH = Twitter::HTTPAuth.new(TWITTER_USERNAME, TWITTER_PASSWORD)
