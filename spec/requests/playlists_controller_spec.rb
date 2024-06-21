require 'rails_helper'
require 'support/factory_bot'

describe PlaylistsController do
  before do
    @playlist =  create :playlist, { id: 123, date: '2000-01-01' } 
  end

  describe "GET #index" do
    before do
      get "/playlists", params: {format: :html}
    end

    it "redirects to first playlist" do
      expect(response).to redirect_to("/playlists/123")
    end
  end

  describe "GET #show" do
    before do
      get "/playlists/#{@playlist.id}", params: {format: :html}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing playlist" do
      record = nil
      expect(response.body).to match("January 1, 2000")
    end
  end
end
