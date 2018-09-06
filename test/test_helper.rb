ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/rails"

require 'fixture_dependencies'
require 'fixture_dependencies/sequel'
require 'fixture_dependencies/helper_methods'

FixtureDependencies.verbose = 0
FixtureDependencies.fixture_path = 'test/fixtures'

class ActiveSupport::TestCase
  include FixtureDependencies::HelperMethods

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  def run(*args, &block)
    Sequel::Model.db.transaction(rollback: :always, auto_savepoint: true) { super }
  end

  # Add more helper methods to be used by all tests here...
end
