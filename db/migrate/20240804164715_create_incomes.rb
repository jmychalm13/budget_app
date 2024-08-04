class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.decimal :amount
      t.string :source
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
