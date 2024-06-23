require 'rails_helper'
require 'support/factory_bot'

describe PlaylistsController do
  let! :playlist do
    create :playlist, { id: 123, date: '2000-01-01' }
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
      get "/playlists/123", params: {format: :html}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "respondsß with HTML body containing playlist" do
      record = nil
      expect(response.body).to match("January 1, 2000")
    end
  end

  describe "GET #date_info" do
    before do
      # response = instance_double(Net::HTTP)
      # allow(Net::HTTP).to receive(:get_response).and_return(
      #   {"apiversion"=>"4.0.1", "geometry"=>{"coordinates"=>[-122.64, 45.56], "type"=>"Point"}, "properties"=>{"data"=>{"closestphase"=>{"day"=>29, "month"=>12, "phase"=>"Last Quarter", "time"=>"14:04", "year"=>1999}, "curphase"=>"Waning Crescent", "day"=>1, "day_of_week"=>"Saturday", "fracillum"=>"23%", "isdst"=>false, "label"=>nil, "month"=>1, "moondata"=>[{"phen"=>"Rise", "time"=>"11:02"}, {"phen"=>"Upper Transit", "time"=>"16:26"}, {"phen"=>"Set", "time"=>"21:44"}], "sundata"=>[{"phen"=>"Set", "time"=>"00:36"}, {"phen"=>"End Civil Twilight", "time"=>"01:10"}, {"phen"=>"Begin Civil Twilight", "time"=>"15:17"}, {"phen"=>"Rise", "time"=>"15:51"}, {"phen"=>"Upper Transit", "time"=>"20:14"}], "tz"=>0.0, "year"=>2000}}, "type"=>"Feature"}.to_json
      # )
      allow_any_instance_of(Net::HTTPOK).to receive(:body).and_return(
        {"apiversion"=>"4.0.1", "geometry"=>{"coordinates"=>[-122.64, 45.56], "type"=>"Point"}, "properties"=>{"data"=>{"closestphase"=>{"day"=>29, "month"=>12, "phase"=>"Last Quarter", "time"=>"14:04", "year"=>1999}, "curphase"=>"Waning Crescent", "day"=>1, "day_of_week"=>"Saturday", "fracillum"=>"23%", "isdst"=>false, "label"=>nil, "month"=>1, "moondata"=>[{"phen"=>"Rise", "time"=>"11:02"}, {"phen"=>"Upper Transit", "time"=>"16:26"}, {"phen"=>"Set", "time"=>"21:44"}], "sundata"=>[{"phen"=>"Set", "time"=>"00:36"}, {"phen"=>"End Civil Twilight", "time"=>"01:10"}, {"phen"=>"Begin Civil Twilight", "time"=>"15:17"}, {"phen"=>"Rise", "time"=>"15:51"}, {"phen"=>"Upper Transit", "time"=>"20:14"}], "tz"=>0.0, "year"=>2000}}, "type"=>"Feature"}.to_json
      )
      get "/playlists/123/date_info", params: {format: :html}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "responds with HTML body containing date info" do
      record = nil
      expect(response.body).to match("January 1, 2000")
    end
  end
end
