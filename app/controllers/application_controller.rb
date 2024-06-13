class ApplicationController < ActionController::API
  include ActionController::MimeResponds # TODO: is it better to use gem 'responders'

  before_action :cross_origin_header

  def cross_origin_header
    response.set_header 'Access-Control-Allow-Origin', 'http://localhost:3000'
  end
end
