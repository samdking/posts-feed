PostsResponse = Struct.new(:posts, :error_message) do
  def success?
    error_message.nil?
  end
end

class PostService
  def posts
    response = HTTParty.get('https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json')

    if response.success?
      body = JSON.parse(response.body)
      PostsResponse.new(body.map { |post| Post.new(post) })
    else
      PostsResponse.new([], response.message)
    end
  end
end
