require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test "a url is valid" do
    url = Url.create(url: "http://www.laurawhalin.com", short_url: "r832u.jf")
    assert url.valid?
  end

  should validate_presence_of(:url)
  should allow_value('http://foo.com', 'http://bar.com/baz').
  for(:url)
  should validate_presence_of(:short_url)
  should validate_uniqueness_of(:short_url)

  test "can generate a shortened url" do
    short_url = Url.shorten
    assert_equal 8, short_url.split("").count
  end
end
