require 'net/http'

class PostsController < ApplicationController
  before_action :create_anonymous_user
  before_action :load_posts

  def index
    @likes = Like.where(post_id: @posts.map(&:id)).group(:post_id).count
  end

  def like
    post = @posts.find { |p| p.id == params[:id].to_i }

    if (like = @anonymous_user.likes.find { |like| like.post_id == post.id })
      like.destroy
    else
      like = @anonymous_user.likes.create(post_id: post.id)
    end

    Turbo::StreamsChannel.broadcast_replace_to "posts",
      target: "like_#{post.id}",
      partial: "posts/like",
      locals: {
        post: post
      }

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("like_#{post.id}", partial: 'like', locals: { post: post })}
      format.html         { redirect_to posts_url }
    end
  end

  protected

  def create_anonymous_user
    if (user_id = cookies.signed[:anon_user])
      @anonymous_user = AnonymousUser.find(user_id)
    else
      @anonymous_user = AnonymousUser.create
      cookies.signed[:anon_user] = @anonymous_user.id
    end
  end

  def load_posts
    @response = PostService.new.posts
    @posts = @response.posts
  end
end
