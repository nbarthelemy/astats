module Api::V1
  class TopReferrersController < Api::V1::ApiController

    def index
      json = Rails.cache.fetch('top_referrers_index_json', expires_in: 1.hour) do
        PageView.daily_top_five_referrers_by_url_since(5.days.ago.to_date).to_json
      end
      render json: json
    end

  end
end