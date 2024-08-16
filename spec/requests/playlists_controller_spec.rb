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

    it "responds with HTML body containing playlist" do
      expect(response.body).to match("January 1, 2000")
    end
  end

  describe "GET #date_info" do
    before do
      response_astronomical = instance_double(
        Net::HTTPSuccess,
        :body => {"apiversion"=>"4.0.1", "geometry"=>{"coordinates"=>[-122.64, 45.56], "type"=>"Point"}, "properties"=>{"data"=>{"closestphase"=>{"day"=>29, "month"=>12, "phase"=>"Last Quarter", "time"=>"14:04", "year"=>1999}, "curphase"=>"Waning Crescent", "day"=>1, "day_of_week"=>"Saturday", "fracillum"=>"23%", "isdst"=>false, "label"=>nil, "month"=>1, "moondata"=>[{"phen"=>"Rise", "time"=>"11:02"}, {"phen"=>"Upper Transit", "time"=>"16:26"}, {"phen"=>"Set", "time"=>"21:44"}], "sundata"=>[{"phen"=>"Set", "time"=>"00:36"}, {"phen"=>"End Civil Twilight", "time"=>"01:10"}, {"phen"=>"Begin Civil Twilight", "time"=>"15:17"}, {"phen"=>"Rise", "time"=>"15:51"}, {"phen"=>"Upper Transit", "time"=>"20:14"}], "tz"=>0.0, "year"=>2000}}, "type"=>"Feature"}.to_json,
        :code => 200
      )
      allow(response_astronomical).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)

      response_headlines = instance_double(
        Net::HTTPSuccess,
        :body => {"meta"=>{"found"=>123, "returned"=>3, "limit"=>3, "page"=>1}, "data"=>[{"uuid"=>"b7677bbb-2cf4-4b86-a3b7-8bcdcaa52654", "title"=>"Family of Idaho stabbings suspect expresses support for him, sympathy for victims", "description"=>"The parents and sister of Bryan Kohberger, who is charged with killing four University of Idaho students, expressed support for him and sympathy for the victims...", "keywords"=>"", "snippet"=>"Listen Comment Gift Article Share\n\nThe parents and sister of Bryan Kohberger, who is charged with killing four University of Idaho students in November, express...", "url"=>"https://www.washingtonpost.com/nation/2023/01/01/idaho-stabbings-suspect-family-statement/", "image_url"=>"https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/7L3U3M3XCHA7MKDQIQ4FCYGHAQ.jpg&w=1440", "language"=>"en", "published_at"=>"2023-01-01T23:56:58.000000Z", "source"=>"washingtonpost.com", "categories"=>["general"], "relevance_score"=>nil, "locale"=>"us"}, {"uuid"=>"47577cf5-605d-4139-b3a6-9aa509f2d09c", "title"=>"Spirits high as Bruins share the ice with their families", "description"=>"As an energetic Bruins practice was winding down on the ice, David Pastrnak was taking one-timers for TNT’s cameras, former Bruin and current analyst Anson Ca...", "keywords"=>"", "snippet"=>"Chara seemed genuinely impressed, praising the skill of the pilot, who narrowly avoided scraping the heads of the typing reporters.\n\n“Wow!” Chara said, as a...", "url"=>"https://www.bostonglobe.com/2023/01/01/sports/spirits-high-bruins-share-ice-with-their-families/?camp=bg:brief:rss:feedly&rss_id=feedly_rss_brief", "image_url"=>"https://bostonglobe-prod.cdn.arcpublishing.com/resizer/vOhPVYuXNiWEirn8ujs5aJKGpCw=/506x0/cloudfront-us-east-1.images.arcpublishing.com/bostonglobe/VOBDDR63UECG4YKSRWOVUQ7D7Q.jpg", "language"=>"en", "published_at"=>"2023-01-01T23:55:54.000000Z", "source"=>"bostonglobe.com", "categories"=>["general"], "relevance_score"=>nil, "locale"=>"us"}, {"uuid"=>"b7988efd-85bf-40c4-bfc7-3c118703b296", "title"=>"Swansea motorcyclist suffers serious injuries in Middleborough crash", "description"=>"The 59-year-old motorcyclist sustained lower-body injuries and was flown to Rhode Island Hospital in Providence by a medical helicopter, police said.", "keywords"=>"", "snippet"=>"A Swansea motorcyclist suffered serious but non-life-threatening injuries after he was struck by a minivan in Middleborough on Sunday morning, police said.\n\nThe...", "url"=>"https://www.bostonglobe.com/2023/01/01/metro/swansea-motorcyclist-suffers-serious-injuries-middleborough-crash/?camp=bg:brief:rss:feedly&rss_id=feedly_rss_brief", "image_url"=>"https://www.bostonglobe.com/pf/resources/images/logo-bg.jpg?d=379", "language"=>"en", "published_at"=>"2023-01-01T23:51:34.000000Z", "source"=>"bostonglobe.com", "categories"=>["general"], "relevance_score"=>nil, "locale"=>"us"}]}.to_json,
        :code => 200
      )
      allow(response_headlines).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)

      # Call original method for non-matching cases
      allow(Net::HTTP).to receive(:get_response).and_call_original

      allow(Net::HTTP).to receive(:get_response).with(
        satisfy { |uri| uri.to_s.include?('aa.usno.navy.mil')}
      ).and_return(response_astronomical)

      allow(Net::HTTP).to receive(:get_response).with(
        satisfy { |uri| uri.to_s.include?('api.thenewsapi.com')}
      ).and_return(response_headlines)

      get "/playlists/123/date_info", params: {format: :html}
    end

    it "responds with HTML body containing date info" do
      expect(response.body).to match("January 1, 2000")
    end

    it "responds with HTML body containing astronomical info" do
      expect(response.body).to match("Upper Transit")
    end

    it "responds with HTML body containing news info" do
      expect(response.body).to match("University of Idaho students")
    end
  end
end
