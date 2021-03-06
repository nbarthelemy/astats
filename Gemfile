source 'https://rubygems.org'
git_source(:github){ |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'

# Use postgres as the database for production
gem 'pg'

# Use sequel as the DSL instead of activerecord
gem 'sequel-rails', '~> 1.0.1'

# Use the native C based sequel_pg adapater. See: https://github.com/jeremyevans/sequel_pg
gem 'sequel_pg', '~> 1.11', require: 'sequel'

# # Use SCSS for stylesheets
# gem 'sass-rails', '~> 5.0'

# # Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use webpacker for asset delivery
gem 'webpacker', '~> 3.5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use faker for generating example data set
gem 'faker', '~> 1.9.1'

group :development do
  # use foreman to run webpack-dev-server
  gem 'foreman'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [ :mri, :mingw, :x64_mingw ]
  gem 'minitest-rails', '~> 3.0'
end

group :test do
  # fixtures for Sequel
  gem 'fixture_dependencies'
end