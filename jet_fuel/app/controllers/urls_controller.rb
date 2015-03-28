class UrlsController < ApplicationController
  def index
    @url = Url.new
  end

  def create
    redirect_to root_url
  end
end
