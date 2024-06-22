require 'rails_helper'
require 'support/factory_bot'

describe ArtistsController do
  let!(:artist) { create :artist, { name: 'Hello World' } }

  before do
  end

  describe "GET #index" do
    before do
      get '/artists', params: {format: format}
    end

    context "with html format" do
      let(:format) { :html }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "with json format" do
      let(:format) { :json }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "response with JSON body containing artist" do
        record = nil
        expect { record = JSON.parse(response.body) }.not_to raise_exception
        expect(record[0].slice('id', 'name')).to match({
        'id' => artist.id,
        'name' => 'Hello World'
        })
      end
    end
  end

  describe "GET #show" do
    let!(:spotify_artist) do
      double(RSpotify::Artist).tap do |artist|
        allow(artist).to receive(:name).and_return "Herbie Hancock"
        allow(artist).to receive(:genres).and_return [
          "contemporary post-bop", "instrumental funk", "jazz", "jazz funk", "jazz fusion", "jazz piano"
        ]
        allow(artist).to receive(:related_artists).and_return [
          related_artist
        ]
      end
    end

    let(:related_artist) do
      double(RSpotify::Artist).tap do |artist|
        allow(artist).to receive(:name).and_return "Chick Corea"
        allow(artist).to receive(:genres).and_return [
          "bebop", "contemporary post-bop", "ecm-style jazz", "electric bass", "jazz", "jazz funk", "jazz fusion", "jazz piano"
        ]
      end
    end

    before do
      allow(RSpotify::Artist).to receive(:search).and_return([
        spotify_artist
      ])
      get "/artists/#{artist.id}", params: {format: format}
    end

    context "with html format" do
      let(:format) { :html }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "responds with HTML body containing artist name" do
        expect(response.body).to match('Hello World')
      end
        
      it "queries spotify api for more info" do
        expect(response.body).to match('Chick Corea')
        expect(response.body).to match('contemporary post-bop')
      end
    end

    context "with json format" do
      let(:format) { :json }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "responds with JSON body containing artist name" do
        record = nil
        expect { record = JSON.parse(response.body) }.not_to raise_exception
        expect(record.slice('id', 'name')).to match({
          'id' => artist.id,
          'name' => 'Hello World'
        })
      end
    end
  end
end
