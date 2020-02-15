class CreateBoardcomments < ActiveRecord::Migration[5.2]
  def change
    create_table :boardcomments do |t|
      t.integer :board_id, null: false
      t.string :comment, null: false
      t.string :commentator, null: false

      t.timestamps
    end
  end
end
