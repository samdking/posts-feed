require "test_helper"
require "post_service"

class PostServiceTest < ActiveSupport::TestCase
  test "it returns an array of posts if successful" do
    HTTParty.expects(:get).returns(stub(success?: true, body: '[{"title":"My First Post"}]'))

    response = PostService.new.posts

    assert_kind_of PostsResponse, response
    assert response.success?
    assert_equal "My First Post", response.posts.first.title
  end

  test "it returns an empty array of posts if unsuccessful" do
    HTTParty.expects(:get).returns(stub(success?: false, message: "There was a problem"))

    response = PostService.new.posts

    assert_kind_of PostsResponse, response
    assert_not response.success?
    assert_empty response.posts
    assert_equal "There was a problem", response.error_message
  end
end
