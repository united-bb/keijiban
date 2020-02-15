class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :board_name, null: false
      t.string :genre, null: false
      t.string :creator_name, null: false

      t.timestamps
    end
  end
end
