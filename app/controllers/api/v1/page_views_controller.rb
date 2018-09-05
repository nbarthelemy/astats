module Api::V1
  class PageViewsController < ApiController

    def index
      json = Rails.cache.fetch('page_views_index_json', expires_in: 1.hour) do
        PageView.daily_visits_by_url_since(5.days.ago.to_date).to_json
      end
      render json: json
    end

  end
end