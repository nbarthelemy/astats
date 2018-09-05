module Api::V1
  class PageViewsController < ApiController

    def index
      render json: PageView.daily_visits_by_url_since(5.days.ago.to_date).to_json
    end

  end
end