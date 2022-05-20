class Post < OpenStruct
  def free?
    value['price'] == 0
  end
end
