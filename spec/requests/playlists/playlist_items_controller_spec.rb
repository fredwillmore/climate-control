require 'rails_helper'
require 'support/factory_bot'

describe Playlists::PlaylistItemsController do
  let!(:artist) { create :artist, name: 'Test Artist' }
  let!(:track) { create :track, name: 'Hello World', artist: artist }
  let!(:track2) { create :track, name: 'Second Track', artist: artist }
  let!(:track3) { create :track, name: 'Third Track', artist: artist }
  let!(:playlist) { create :playlist, date: '2000-01-01' }
  let!(:playlist_item) { create :playlist_item, track: track, playlist: playlist, position: 1 }
  let!(:playlist_item2) { create :playlist_item, track: track2, playlist: playlist, position: 2 }
  let!(:playlist_item3) { create :playlist_item, track: track3, playlist: playlist, position: 3 }

  describe "GET #index" do
    before do
      get "/playlists/#{playlist.id}/playlist_items", params: { format: :html }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing playlist item" do
      record = nil
      expect(response.body).to match('Hello World')
    end
  end

  describe "GET #show" do
    before do
      get "/playlists/#{playlist.id}/playlist_items/#{playlist_item.id}", params: { format: :html }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with HTML body containing artist" do
      expect(response.body).to match('Test Artist')
    end
  end

  describe "GET #first" do
    before do
      get "/playlists/#{playlist.id}/playlist_items/first"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing artist" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record.slice('id', 'position')).to match({
       'id' => playlist_item.id,
       'position' => 1
      })
    end
  end

  describe "GET #last" do
    before do
      get "/playlists/#{playlist.id}/playlist_items/last"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing artist" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record.slice('id', 'position')).to match({
       'id' => playlist_item3.id,
       'position' => 3
      })
    end
  end

  describe "GET #next" do
    before do
      get "/playlists/#{playlist.id}/playlist_items/#{playlist_item.id}/next"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing artist" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record.slice('id', 'position')).to match({
       'id' => playlist_item2.id,
       'position' => 2
      })
    end
    
    it "returns null for next on last item" do
      record = 'not nil'
      get "/playlists/#{playlist.id}/playlist_items/#{playlist_item3.id}/next"
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record).to be_nil
    end
  end

  describe "GET #previous" do
    before do
      get "/playlists/#{playlist.id}/playlist_items/#{playlist_item.id}/previous"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing artist" do
      record = nil
      get "/playlists/#{playlist.id}/playlist_items/#{playlist_item3.id}/previous"
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record.slice('id', 'position')).to match({
       'id' => playlist_item2.id,
       'position' => 2
      })
    end
    
    it "returns null for previous on first item" do
      record = 'not nil'
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record).to be_nil
    end
  end
end
