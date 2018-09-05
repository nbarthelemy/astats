class PageView < Sequel::Model

  def self.daily_visits_by_url_since(date)
    sql = <<-SQL
      SELECT created_at::DATE, url, count(url) as visits
      FROM page_views
      WHERE created_at::DATE > ?
      GROUP BY created_at::DATE, url
      ORDER BY created_at::DATE desc, visits desc
    SQL

    self.db[sql, date].all.group_by do |record|
      record[:created_at].to_s(:db)
    end
  end

end
