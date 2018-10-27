require 'rails_helper'
require 'support/factory_bot'

describe PlaylistsController do
  before do
    @playlist =  create :playlist, { date: '2000-01-01' } 
  end

  describe "GET #index" do
    before do
      get :index, params: {format: :json}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing playlist" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record[0].slice('id', 'date')).to match({
       'id' => @playlist.id,
       'date' => '2000-01-01'
      })
    end
  end

  describe "GET #show" do
    before do
      get :show, params: {id: @playlist.id, format: :json}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing playlist" do
      record = nil
      expect { record = JSON.parse(response.body) }.not_to raise_exception
      expect(record.slice('id', 'date')).to match({
       'id' => @playlist.id,
       'date' => '2000-01-01'
      })
    end
  end
end
