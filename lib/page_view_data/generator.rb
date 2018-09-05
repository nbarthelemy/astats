require 'page_view_data/record_set'
require 'faker/internet'

module PageViewData
  class Generator

    attr_reader :number_of_records

    def self.run(number_of_records = 1_000_000)
      # initialize a genertor
      generator = self.new(number_of_records)

      # determine batching strategy
      step_by = number_of_records >= 1000 ? 1000 : number_of_records

      # step through each batch and insert a new record set
      1.step(by: step_by, to: number_of_records).each do |id|
        Sequel::Model.db.run(PageViewData::RecordSet.new(generator, id).to_sql)
      end
    end

    def initialize(number_of_records = 1_000_000)
      @number_of_records = number_of_records
    end

    def urls
      @urls ||= PageViewData::REQUIRED_URLS + fake_urls
    end

    def referrers
      @referrers ||= PageViewData::REQUIRED_REFERRERS + fake_urls + ( [ nil ] * 12 )
    end

    def random_url
      self.urls[rand(self.urls.size)]
    end

    def random_referrer
      self.referrers[rand(self.referrers.size)]
    end

    def random_timestamp
      rand(15).days.ago.to_s(:db)
    end

    def fake_urls
      @fake_urls ||= ( 1 .. 100 ).collect do
        "http://" + Faker::Internet.domain_name
      end
    end
  end
end
