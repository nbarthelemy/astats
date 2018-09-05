require 'page_view_data'
require 'benchmark'

Benchmark.bm do |x|
  # Truncate the page_views table
  x.report("truncate") { Sequel::Model.db[:page_views].truncate }

  # Generate a dataset with 1 million rows
  x.report("generate") { PageViewData::Generator.run(1_000_000) }
end