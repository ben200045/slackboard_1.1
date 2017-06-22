class CreateGroupChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :group_channels do |t|
      t.references :group, foreign_key: true
      t.references :channel, foreign_key: true

      t.timestamps
    end
  end
end
