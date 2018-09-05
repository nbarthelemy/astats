require 'page_view_data/generator'
require 'page_view_data/record_set'

module PageViewData

  REQUIRED_URLS = [
    "http://apple.com",
    "https://apple.com",
    "https://www.apple.com",
    "http://developer.apple.com",
    "http://en.wikipedia.org",
    "http://opensource.org"
  ].freeze

  REQUIRED_REFERRERS = [
    "http://apple.com",
    "https://apple.com",
    "https://www.apple.com",
    "http://developer.apple.com",
    nil
  ].freeze

end