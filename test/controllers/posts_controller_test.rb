require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "posts are displayed" do
    posts = build_list(:post, 5)

    stub_successful_posts_response(posts)

    get root_path

    assert_select 'li', count: 5
  end

  test "posts of zero price are displayed under a 'Free' heading" do
    post = build(:post, value: { 'price' => 0 })

    stub_successful_posts_response([post])

    get root_path

    assert_select 'h1', text: 'Free Items'
  end

  test "posts with a non-zero price are displayed under a 'Paid' heading" do
    post = build(:post, value: { 'price' => 10 })

    stub_successful_posts_response([post])

    get root_path

    assert_select 'h1', text: 'Paid Items'
  end

  test "posts contain a like button" do
    stub_successful_posts_response(build_list(:post, 1, reactions: { 'likes' => 5 }))

    get root_path

    assert_select '.like-button', text: '❤️ 5'
  end

  test 'an anonymous user is created when viewing posts' do
    assert_changes -> { AnonymousUser.count } do
      get root_path
    end
  end

  test 'a post can be liked' do
    post = build(:post)

    stub_successful_posts_response([post])

    assert_difference -> { Like.where(anonymous_user: AnonymousUser.last, post_id: post.id).count }, 1 do
      post like_post_path(post.id)
    end
  end

  test 'a post can be unliked' do
    post = build(:post)

    stub_successful_posts_response([post])

    get root_path

    create(:like, post_id: post.id, anonymous_user: AnonymousUser.last)

    assert_difference -> { Like.count }, -1 do
      post like_post_path(post.id)
    end
  end

  test "likes against a post are added on to the received total" do
    post = build(:post, reactions: { 'likes' => 5 })
    create_list(:like, 3, post_id: post.id)

    stub_successful_posts_response([post])

    get root_path

    assert_select '.like-button', text: '❤️ 8'
  end

  test 'personal likes show as green' do
    user = build(:anonymous_user)

    AnonymousUser.stubs(:create).returns(user)
    post = build(:post)
    other_post = build(:post)
    create(:like, anonymous_user: user, post_id: post.id)

    stub_successful_posts_response([post, other_post])

    get root_path

    assert_select '.like-button.liked', text: '❤️ 1'
    assert_select '.like-button', text: '❤️ 0'
  end

  test 'if request is unsuccessful, display an error message' do
    PostService.any_instance.stubs(:posts).returns(PostsResponse.new([], 'There was an issue'))

    get root_path

    assert_select 'h1', 'Apologies'
    assert_select 'ul', count: 0
  end

  protected

  def stub_successful_posts_response(posts)
    PostService.any_instance.stubs(:posts).returns(PostsResponse.new(posts))
  end
end
