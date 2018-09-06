class PageView < Sequel::Model

  def self.visits_by_url_since(timestamp)
    sql = <<-SQL
      SELECT created_at::DATE, url, count(url) as visits
      FROM page_views
      WHERE created_at >= ?
      GROUP BY created_at::DATE, url
      ORDER BY created_at::DATE desc, visits desc
    SQL

    self.db[sql, timestamp.utc.to_date].all.group_by do |record|
      record[:created_at].to_s(:db)
    end
  end

  def self.top_five_referrers_by_url_since(timestamp)
    sql = <<-SQL
      SELECT urls.created_at, urls.url, urls.visits, urls.row_number,
        referrers.referrer, referrers.referrer_visits, referrers.row_number

      FROM (
        SELECT created_at::DATE, url, COUNT(url) as visits,
          ROW_NUMBER() OVER ( PARTITION BY created_at::DATE ORDER BY COUNT(url) DESC )
        FROM page_views
        WHERE created_at::DATE >= :since_date::DATE
        GROUP BY created_at::DATE, url
      ) AS urls

      INNER JOIN (
        SELECT created_at::DATE, url, referrer, COUNT(referrer) AS referrer_visits,
          ROW_NUMBER() OVER ( PARTITION BY url, created_at::DATE ORDER BY COUNT(referrer) DESC )
        FROM page_views
        WHERE created_at::DATE >= :since_date::DATE
        AND referrer IS NOT NULL
        GROUP BY created_at::DATE, url, referrer
      ) AS referrers

      ON urls.url = referrers.url
      AND urls.created_at::DATE = referrers.created_at::DATE

      WHERE urls.row_number <= 10
      AND referrers.row_number <= 5

      ORDER BY urls.created_at DESC, urls.row_number, url, referrers.row_number
    SQL

    self.db[sql, { since_date: timestamp.utc.to_date }].all.inject({}) do |data, record|
      date = record[:created_at].to_s(:db)
      url = record[:url]
      data[date] ||= {}
      data[date][url] ||= { visits: record[:visits], referrers: [] }
      data[date][url][:referrers] << { url: record[:referrer], visits: record[:referrer_visits] }
      data
    end
  end

end
