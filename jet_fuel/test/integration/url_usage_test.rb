require "test_helper"

class UrlUsageTest < ActionDispatch::IntegrationTest
  test "user enters a url and receives a shortened url" do
    Capybara.current_driver = :selenium
    sample_path = "http://www.laurawhalin.com"

    visit root_path
    fill_in("url[url]", with: sample_path)
    click_link_or_button("Shorten")

    shortened_url = Url.last.short_url
    assert page.has_content?("short url is localhost:3000/#{shortened_url}")

    click_link_or_button("short-url")

    # assert_redirected_to sample_path
  end

  test "clicking a shortened url increases its click tally" do
    sample_path = "http://www.laurawhalin.com"

    visit root_path
    fill_in("url[url]", with: sample_path)
    click_link_or_button("Shorten")

    click_link("short-url", match: :first)

    visit root_path

    within(".tally") do
      assert page.has_content?("1")
    end
  end

  test "can sort the list of urls by when they were added" do
    Url.create(url: "http://www.laurawhalin.com", short_url: "57thr")
    Url.create(url: "https://github.com/laurawhalin", short_url: "55thh")
  end
end
