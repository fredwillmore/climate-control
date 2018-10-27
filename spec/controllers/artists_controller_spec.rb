require 'rails_helper'
require 'support/factory_bot'

describe ArtistsController do
  before do
    @artist = create :artist, { name: 'Hello World' }
  end

  describe "GET #index" do
    before do
      get :index, params: {format: :json}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing artist" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record[0].slice('id', 'name')).to match({
       'id' => @artist.id,
       'name' => 'Hello World'
      })
    end
  end

  describe "GET #show" do
    before do
      get :show, params: {id: @artist.id, format: :json}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing artist" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record.slice('id', 'name')).to match({
       'id' => @artist.id,
       'name' => 'Hello World'
      })
    end
  end
end
