class CreateTwitterusers < ActiveRecord::Migration
  def change
    create_table :twitterusers do |v|
      v.string :username
      v.timestamps null: false

    end
  end
end
