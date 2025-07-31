ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"

# Custom test helper without ActiveRecord
require "action_controller/test_case"
require "action_dispatch/testing/integration"
require "action_view/test_case"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Add more helper methods to be used by all tests here...
  end
end
