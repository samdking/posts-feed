class Like < ApplicationRecord
  belongs_to :anonymous_user

  validates :post_id, uniqueness: { scope: :anonymous_user_id, message: 'can only be liked once per user' }
end
