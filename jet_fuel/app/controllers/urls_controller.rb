class UrlsController < ApplicationController

  def index
    @url = Url.new
    @urls = Url.all
  end

  def create
    short_url = shorten
    url_entry = Url.new(url: url_params[:url], short_url: short_url)

    if url_entry.save
      flash[:success] = "Your shortened url is localhost:3000#{url_path(url_entry)}"
      redirect_to root_url
    else
      flash[:errors] = "Incorrect URL format entered."
      redirect_to root_url
    end
  end

  def show
    url = Url.find_by(short_url: params[:short_url])
    url.tally if url
    redirect_to url.url
  end

  private

  def url_params
    params.require(:url).permit(:url)
  end

  def shorten
    short_url = Url.generate

    while Url.find_by(short_url: short_url) do
      short_url = Url.generate
    end

    short_url
  end
end
