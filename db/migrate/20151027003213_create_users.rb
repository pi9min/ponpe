class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :access_token
      t.string :name
      t.string :email
      t.string :icon_url
      t.integer :permission, default: 0, null: false, limit: 1

      t.timestamps null: false
    end

    add_index :users, [:provider, :uid], unique: true
  end
end
