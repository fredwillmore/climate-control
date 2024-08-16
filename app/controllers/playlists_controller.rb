class PlaylistsController < ApplicationController
  def index
    redirect_to playlist_url(Playlist.first)
  end

  def show
    @playlist = Playlist.find(params[:id]) || Playlist.first
  end
    
  # TODO: fetch API data in separate actions
  def date_info
    @playlist = Playlist.find(params[:id]) || Playlist.first
    @sun_moon_data = sun_moon_data
    @news_stories = news_stories
  end

  private

  def date
    @date ||= @playlist.date.strftime('%Y-%m-%d')
  end

  def news_stories_date
    # Due to the lack of available data from 2003, we are showing news stories from 2023 instead.
    @playlist.date.change(:year => 2023).strftime('%Y-%m-%d')
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

  def news_api_token
    "3WeHgJrsii7CHnNPS2vom2kenkB0irxUe8tiZNXO"
  end

  def news_stories_url
    "https://api.thenewsapi.com/v1/news/top?locale=us&limit=3&published_on=#{news_stories_date}&locale=us&language=en&api_token=#{news_api_token}"
  end

  def news_stories
    return @news_stories if @news_stories

    uri = URI(news_stories_url)
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      @news_stories = JSON::parse(response.body)
    else
      raise StandardError.new "HTTP request failed with status code #{response.code}"
    end

    @news_stories
  end
end
