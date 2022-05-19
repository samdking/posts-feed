class AddAnonymousUserIdToLike < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :anonymous_user
  end
end
