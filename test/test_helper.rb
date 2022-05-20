ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest"

module StubPosts
  def stub_successful_posts_response(posts)
    PostService.any_instance.stubs(:posts).returns(PostsResponse.new(posts))
  end
end

class ActiveSupport::TestCase
  include StubPosts

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
end
