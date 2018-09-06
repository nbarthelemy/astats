require "test_helper"

class Api::V1::TopReferrersControllerTest < ActionController::TestCase

  setup do
    FixtureDependencies.load(:page_view__apple_google_1_days_ago)
    FixtureDependencies.load(:page_view__apple_google_2_days_ago)
    FixtureDependencies.load(:page_view__apple_google_3_days_ago)
    FixtureDependencies.load(:page_view__apple_google_4_days_ago)
    FixtureDependencies.load(:page_view__apple_google_5_days_ago)
  end

  test '#index' do
    get :index
    assert_response :success

    expected_response = (1..5).inject({}) do |response, n|
      date = n.days.ago.utc.to_date
      response[date.to_s(:db)] = {
        "http://apple.com" => {
          "visits" => 1,
          "referrers" => [{ "url" => "http://google.com", "visits" => 1 }]
        }
      }
      response
    end

    assert_equal expected_response, JSON.parse(@response.body)
  end

end
