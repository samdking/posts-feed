class Like < ApplicationRecord
  belongs_to :anonymous_user

  validates :anonymous_user_id, uniqueness: { scope: :post_id }
end
