module PageViewData
  class RecordSet

    attr_reader :last_id, :generator
    attr_accessor :current_id

    def initialize(generator, first_id = 1, records_in_set = 1000)
      @generator  = generator
      @current_id = first_id
      @last_id    = first_id + records_in_set - 1
    end

    def required_url_records
      @required_url_records ||= PageViewData::REQUIRED_URLS.
        collect.with_index(current_id) do |url, id|
          self.current_id += 1
          build_sql_value_string(id, url, generator.random_referrer, generator.random_timestamp)
      end
    end

    def required_referrer_records
      @required_referrer_records ||= PageViewData::REQUIRED_REFERRERS.
        collect.with_index(current_id) do |referrer, id|
          self.current_id += 1
          build_sql_value_string(id, generator.random_url, referrer, generator.random_timestamp)
      end
    end

    def random_records
      @random_records ||= ( current_id .. last_id ).collect do |id|
        build_sql_value_string(id, generator.random_url, generator.random_referrer, generator.random_timestamp)
      end
    end

    def records
      [ required_url_records, required_referrer_records, random_records ].flatten
    end

    def to_sql
      "INSERT INTO page_views VALUES #{records.join(", ")}"
    end

  private

    def md5_hash(hash)
      Digest::MD5.hexdigest(hash.compact.to_s)
    end

    def build_sql_value_string(id, url, referrer, created_at)
      hash_value = md5_hash(id: id, url: url, referrer: referrer, created_at: created_at)
      "(#{id}, '#{url}', #{referrer.nil? ? "null" : "'#{referrer}'"}, '#{hash_value}', '#{created_at}')"
    end

  end
end