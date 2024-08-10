case Rails::env
when "development", "test"
  spotify_client_id = Rails.application.credentials['spotify_client_id']
  spotify_client_secret = Rails.application.credentials['spotify_client_secret']
when "production"
  spotify_client_id = ENV['SPOTIFY_CLIENT_ID']
  spotify_client_secret = ENV['SPOTIFY_CLIENT_SECRET']
else
  spotify_client_id = 'FIXME'
  spotify_client_secret = 'FIXME'
end

RSpotify.authenticate(
  spotify_client_id,
  spotify_client_secret
)
