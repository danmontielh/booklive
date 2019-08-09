class CreateLetters < ActiveRecord::Migration[5.2]
  def change
    create_table :letters do |t|
      t.references :sender, index: true
      t.references :receiver, index: true
      t.text :message
      t.timestamps
    end
  end
end
