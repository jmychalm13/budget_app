class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.string :category
      t.decimal :amount
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
