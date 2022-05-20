require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test "a post can be liked" do
    stub_successful_posts_response([build(:post)])

    visit root_url

    assert_selector '.like-button a', text: '❤️ 0'

    find('.like-button a').click

    assert_selector '.like-button.liked a', text: '❤️ 1'
  end

  test "a post I like can be unliked" do
    stub_successful_posts_response([build(:post)])

    visit root_url

    find('.like-button a').click
    assert_selector '.like-button.liked a', text: '❤️ 1'

    find('.like-button a').click
    assert_selector '.like-button a', text: '❤️ 0'
  end

  test "a post with initial likes can be liked" do
    stub_successful_posts_response([build(:post, reactions: { 'likes' => 3 })])

    visit root_url

    find('.like-button a').click
    assert_selector '.like-button.liked a', text: '❤️ 4'
  end
end
