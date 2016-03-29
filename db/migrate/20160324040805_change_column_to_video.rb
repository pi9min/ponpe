# durationとrecorded_atがNULLだと困るのでNOT NULLに変更
class ChangeColumnToVideo < ActiveRecord::Migration
  def up
    change_column :videos, :duration, :integer, null: false, default: 0
    change_column :videos, :recorded_at, :datetime, null: false, default: '1970-01-01 00:00:00'
  end

  # 変更前の状態
  def down
    change_column :videos, :duration, :integer, null: true
    change_column :videos, :recorded_at, :datetime, null: true
  end
end
