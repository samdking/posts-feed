PostsResponse = Struct.new(:posts, :error_message) do
  def success?
    error_message.nil?
  end
end

class PostService
  def posts
    uri = URI('https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json')

    response = Net::HTTP.get(uri)

    body = JSON.parse(response)

    PostsResponse.new(body.map { |post| OpenStruct.new(post) })
  rescue SocketError => e
    PostsResponse.new([], e.message)
  end
end
