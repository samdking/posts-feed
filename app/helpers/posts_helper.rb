module PostsHelper
  def likes_for_post(post)
    additional_likes = (@likes ? (@likes[post.id] || 0) : Like.where(post_id: post.id).count)

    post.reactions['likes'] + additional_likes
  end

  def liked_post?(post)
    @anonymous_user.likes.map(&:post_id).include?(post.id)
  end
end
