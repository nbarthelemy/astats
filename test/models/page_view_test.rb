require 'test_helper'

class PageViewTest < ActiveSupport::TestCase

  setup do
    FixtureDependencies.load(:page_view__apple_google_1_days_ago)
    FixtureDependencies.load(:page_view__apple_google_2_days_ago)
    FixtureDependencies.load(:page_view__apple_google_3_days_ago)
    FixtureDependencies.load(:page_view__apple_google_4_days_ago)
    FixtureDependencies.load(:page_view__apple_google_5_days_ago)
  end

  describe "#visits_by_url_since" do
    it "should return the correctly formatted data structure" do
      expected_response = (1..5).inject({}) do |response, n|
        date = n.days.ago.utc.to_date
        response[date.to_s(:db)] = [{ url: "http://apple.com", visits: 1, created_at: date }]
        response
      end
      PageView.visits_by_url_since(5.days.ago).must_equal expected_response
    end
  end

  describe "#top_five_referrers_by_url_since" do
    it "should return the correctly formatted data structure" do
      expected_response = (1..5).inject({}) do |response, n|
        date = n.days.ago.utc.to_date
        response[date.to_s(:db)] = {
          "http://apple.com" => {
            visits: 1,
            referrers: [{ url: "http://google.com", visits: 1 }]
          }
        }
        response
      end
      PageView.top_five_referrers_by_url_since(5.days.ago).must_equal expected_response
    end
  end

  describe "instance_methods" do
    describe "#md5_hash" do
      setup do
        @page_view = PageView.create(url: 'http://apple.com', referrer: nil)
      end

      it "should generate an md5_hash for the record before_save" do
        assert_not_nil @page_view.hash
      end

      it "should add a created_at timestamp for the record before_save" do
        assert_not_nil @page_view.created_at
      end
    end
  end

end
