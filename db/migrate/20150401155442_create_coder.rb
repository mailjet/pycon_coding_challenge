class CreateCoder < ActiveRecord::Migration
  def change
    create_table :coders do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :position
      t.text :array
      t.string :answer
      t.boolean :is_correct
      t.string :time

    end
  end
end
