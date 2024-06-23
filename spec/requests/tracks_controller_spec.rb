require 'rails_helper'
require 'support/factory_bot'

describe TracksController do
  let!(:artist) { create :artist, { name: 'Herbie Hancock' } }
  let!(:track) { create :track, { name: 'Watermelon Man', artist: artist } }

  describe "GET #index" do
    before do
      get '/tracks', params: { format: format }
    end

    context "with html format" do
      let(:format) { :html }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders a template" do
        expect(response).to render_template(:index)
      end
    end

    context "with json format" do
      let(:format) { :json }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "response with JSON body containing playlist" do
        record = nil
        expect { record = JSON.parse(response.body) }.not_to raise_exception
        expect(record[0].slice('id', 'name')).to match({
          'id' => track.id,
          'name' => 'Watermelon Man'
        })
      end
    end
  end
  describe "GET #show" do
    let!(:spotify_track) do
      double(RSpotify::Track).tap do |track|
        allow(track).to receive(:id).and_return "2zQl59dZMzwhrmeSBEgiXY"
        allow(track).to receive(:external_urls).and_return("spotify"=>"https://open.spotify.com/track/2zQl59dZMzwhrmeSBEgiXY")
        allow(track).to receive(:name).and_return "Watermelon Man"
        allow(track).to receive(:artists).and_return [spotify_artist]
        allow(track).to receive(:album).and_return spotify_album
      end
    end

    let!(:spotify_album) do
      double(RSpotify::Album).tap do |album|
        allow(album).to receive(:name).and_return "Head Hunters"
        allow(album).to receive(:artists).and_return [spotify_artist]
      end
    end

    let!(:spotify_artist) do
      double(RSpotify::Artist).tap do |artist|
        allow(artist).to receive(:name).and_return "Herbie Hancock"
        allow(artist).to receive(:genres).and_return [
          "contemporary post-bop", "instrumental funk", "jazz", "jazz funk", "jazz fusion", "jazz piano"
        ]
      end
    end

    before do
      allow(RSpotify::Track).to receive(:search).and_return([
        spotify_track
      ])
      allow(RSpotify::Artist).to receive(:search).and_return([
        spotify_artist
      ])
      get "/tracks/#{track.id}", params: {format: format}
    end

    context "with html format" do
      let(:format) { :html }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "responds with HTML body containing track name, artist name, album name, and link to track" do
        expect(response.body).to match('Watermelon Man')
        expect(response.body).to match('Herbie Hancock')
        expect(response.body).to match('Head Hunters')
        expect(response.body).to match('https://open.spotify.com/track/2zQl59dZMzwhrmeSBEgiXY')
      end
    end
  
    context "with json format" do
      let(:format) { :json }
    
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "responds with JSON body containing track name" do
        record = nil
        expect { record = JSON.parse(response.body) }.not_to raise_exception
        expect(record.slice('id', 'name')).to match({
          'id' => track.id,
          'name' => 'Watermelon Man'
        })
      end
    end
  end
end
