require 'rails_helper'
require 'support/factory_bot'

describe ApiInteraction do
  subject { ApiInteraction.new artist }
  let(:artist) { create :artist, id: 123, name: "Test Artist Name" }
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

  describe :get_spotify_data do
    before do
      expect(Rails.cache).to receive(:read).with("artist_123").and_return(cached_result)
    end

    context "when result is not in cache" do
      let(:cached_result) { nil }

      it "queries the api" do
        allow(Rails.cache).to receive(:write)

        expect(RSpotify::Artist).to receive(:search).with("Test Artist Name").and_return([spotify_artist])
        subject.get_spotify_data
      end

      it "writes the result to the rails cache" do
        expect(Rails.cache).to receive(:write).with("artist_123", spotify_artist)

        allow(RSpotify::Artist).to receive(:search).with("Test Artist Name").and_return([spotify_artist])
        subject.get_spotify_data
      end
    end

    context "when result is in cache" do
      let(:cached_result) { spotify_artist }

      it "does not query the api" do
        expect(RSpotify::Artist).not_to receive(:search)
        subject.get_spotify_data
      end

      it "does not write the result to the rails cache" do
        expect(Rails.cache).not_to receive(:write)
        subject.get_spotify_data
      end
    end
  end
end
