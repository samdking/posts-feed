class CreateAnonymousUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :anonymous_users do |t|

      t.timestamps
    end
  end
end
