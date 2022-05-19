class PostService
  def posts
    uri = URI('https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json')

    body = JSON.parse(Net::HTTP.get(uri))

    @posts = body.map { |post| OpenStruct.new(post) }
  end
end
