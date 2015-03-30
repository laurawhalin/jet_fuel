require "test_helper"

class UrlTest < ActiveSupport::TestCase
  test "a url is valid" do
    url = Url.create(url: "http://www.laurawhalin.com", short_url: "r832u")
    assert url.valid?
  end

  should validate_presence_of(:url)
  should allow_value("http://foo.com", "http://bar.com/baz").
    for(:url)
  should validate_presence_of(:short_url)
  should validate_uniqueness_of(:short_url)

  test "can generate a short url" do
    short_url = Url.generate
    assert_equal 5, short_url.split("").count
  end

  test "can tally up visits to a url" do
    url = Url.create(url: "http://www.laurawhalin.com", short_url: "r83u5")
    assert_equal 0, url.click_tally
    url.tally
    assert_equal 1, url.click_tally
  end
end
