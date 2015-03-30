class UrlsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @url = Url.new
    # @urls = Url.all
    if params[:sort]
      @urls = Url.order(sort_column + " " + sort_direction)
    else
      @urls = Url.order(click_tally: :desc)
    end
  end

  def create
    short_url = shorten
    url_entry = Url.new(url: url_params[:url], short_url: short_url)

    if url_entry.save
      flash[:success] = "Your short url is localhost:3000#{url_path(url_entry)}"
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

    while Url.find_by(short_url: short_url)
      short_url = Url.generate
    end

    short_url
  end

  def sort_column
    Url.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
