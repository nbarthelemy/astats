require 'test_helper'
require 'page_view_data'

class PageViewDataTest < ActiveSupport::TestCase

  describe "class variables" do
    it "has the requisite required_urls" do
      PageViewData::REQUIRED_URLS.must_equal [
        "http://apple.com",
        "https://apple.com",
        "https://www.apple.com",
        "http://developer.apple.com",
        "http://en.wikipedia.org",
        "http://opensource.org"
      ]
    end

    it "has the requisite referrers" do
      PageViewData::REQUIRED_REFERRERS.must_equal [
        "http://apple.com",
        "https://apple.com",
        "https://www.apple.com",
        "http://developer.apple.com",
        nil
      ]
    end
  end

  describe "RecordSet" do
    setup do
      @generator = PageViewData::Generator.new
    end

    describe "initialization" do
      it "creates a new instance with initial values" do
        record_set = PageViewData::RecordSet.new(@generator)
        record_set.current_id.must_equal 1
        record_set.last_id.must_equal 1000
      end

      it "creates a new instance with specific values given a seed" do
        record_set = PageViewData::RecordSet.new(@generator, 1001, 10000)
        record_set.current_id.must_equal 1001
      end

      it "creates a new instance with specific values given a seed" do
        record_set = PageViewData::RecordSet.new(@generator, 1001, 10000)
        record_set.last_id.must_equal 11000
      end
    end

    describe "#to_sql" do
      it "returns sql to insert the data" do
        record_set = PageViewData::RecordSet.new(@generator, 1, 20)
        record_set.to_sql.must_match /INSERT INTO page_views VALUES (\(.+\), ){19}(\(.+\))/
      end
    end

    describe "#records" do
      it "returns required, referrers and randoms urls" do
        record_set = PageViewData::RecordSet.new(@generator, 1, 100)
        record_set.records.must_equal record_set.required_url_records +
          record_set.required_referrer_records + record_set.random_records
      end
    end

    describe "#required_url_records" do
      it "returns required urls" do
        record_set = PageViewData::RecordSet.new(@generator, 1, 50)
        record_set.required_url_records.size.must_equal 6
        record_set.required_url_records[0].must_match /1,.+apple\.com/
        record_set.required_url_records[1].must_match /2,.+apple\.com/
        record_set.required_url_records[2].must_match /3,.+www\.apple\.com/
        record_set.required_url_records[3].must_match /4,.+developer\.apple\.com/
        record_set.required_url_records[4].must_match /5,.+en\.wikipedia\.org/
        record_set.required_url_records[5].must_match /6,.+opensource\.org/
      end
    end

    describe "#required_referrer_records" do
      it "returns required referrer records" do
        record_set = PageViewData::RecordSet.new(@generator, 1, 50)
        record_set.required_referrer_records.size.must_equal 5
        record_set.required_referrer_records[0].must_match /1,.+?,\s+.+apple\.com/
        record_set.required_referrer_records[1].must_match /2,.+?,\s+.+apple\.com/
        record_set.required_referrer_records[2].must_match /3,.+?,\s+.+www\.apple\.com/
        record_set.required_referrer_records[3].must_match /4,.+?,\s+.+developer\.apple\.com/
        record_set.required_referrer_records[4].must_match /5,.+?,\s+null,/
      end
    end

    describe "#random_records" do
      it "returns random urls and referrers" do
        record_set = PageViewData::RecordSet.new(@generator, 1, 50)
        record_set.random_records.all? do |rec|
          rec.must_match /\d+, 'https?:.+\.(.+)', ('https?.+\.(.+)'|null), '[a-f0-9]{32}', '\d{4}-\d\d-\d\d \d\d:\d\d:\d\d'/
        end
      end
    end
  end

end
