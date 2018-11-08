require 'rails_helper'
require 'support/factory_bot'

describe PlaylistItemsController do
  before do
    @artist = create :artist, { name: 'Hello World' }
    @track =  create :track, { name: 'Hello World', artist: @artist } 
    @playlist =  create :playlist, { date: '2000-01-01' } 
    @playlist_item =  create :playlist_item, { track: @track, playlist: @playlist, position: 1 } 
  end

  describe "GET #index" do
    before do
      get "/playlist_items", params: {format: :json}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing playlist item" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record[0].slice('id', 'position')).to match({
       'id' => @playlist_item.id,
       'position' => 1
      })
    end
  end

  describe "GET #show" do
    before do
      get "/playlist_items/#{@playlist_item.id}", params: {format: :json}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing artist" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record.slice('id', 'position')).to match({
       'id' => @playlist_item.id,
       'position' => 1
      })
    end
  end
end
