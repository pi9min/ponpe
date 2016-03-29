class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :thumbnail_url
      t.string :short_url, limit: 4, collation: 'latin1_bin', null: false
      t.string :file_hash, limit: 40, collation: 'latin1_bin'
      t.string :title, collation: 'utf8mb4_unicode_ci', null: false
      t.string :description, collation: 'utf8mb4_unicode_ci'
      t.integer :category, null: false, default: 99
      t.integer :state, null: false, default: 0
      t.string :chapter
      t.integer :duration
      t.datetime :recorded_at
      t.text :raw_info

      t.timestamps null: false
    end

    add_index :videos, :short_url, unique: true
  end
end
