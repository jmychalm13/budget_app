class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.string :category
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
