require 'test_helper'

class UrlUsageTest < ActionDispatch::IntegrationTest
  test "user enters a url and receives a shortened url" do
    sample_path = "http://www.laurawhalin.com"

    visit root_path
    fill_in("url[url]", with: sample_path)
    click_link_or_button("Shorten")

    assert page.has_content?("Shortened URL:")

    click_link_or_button("#short-url")

    assert current_path, sample_path
  end
end
