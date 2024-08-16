class PlaylistsController < ApplicationController
  def index
    redirect_to playlist_url(Playlist.first)
  end

  def show
    @playlist = Playlist.find(params[:id]) || Playlist.first
  end
    
  def date_info
    @playlist = Playlist.find(params[:id]) || Playlist.first
    @sun_moon_data = sun_moon_data
  end

  private

  def date
    @date ||= @playlist.date.strftime('%Y-%m-%d')
  end

  def latitude
    '45.56'
  end

  def longitude
    '-122.64'
  end

  def sun_moon_data_url
    "https://aa.usno.navy.mil/api/rstt/oneday?date=#{date}&coords=#{latitude},#{longitude}"
  end

  def sun_moon_data
    return @sun_moon_data if @sun_moon_data

    uri = URI(sun_moon_data_url)
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      @sun_moon_data = JSON::parse(response.body)
    else
      raise StandardError.new "HTTP request failed with status code #{response.code}"
    end

    @sun_moon_data
  end
end
