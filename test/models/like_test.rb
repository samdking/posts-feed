require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "a user can only have 1 like per post" do
    like = create(:like, post_id: 123)

    assert_not build(:like, post_id: 123, anonymous_user: like.anonymous_user).valid?
    assert create(:like, post_id: 456, anonymous_user: like.anonymous_user).valid?
    assert create(:like, post_id: 123).valid?
  end
end
