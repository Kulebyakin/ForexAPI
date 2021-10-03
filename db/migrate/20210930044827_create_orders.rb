class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :from_account_id, null: false, foreign_key: true
      t.integer :to_account_id, null: false, foreign_key: true
      t.integer :amount, null: false
      t.float :desired_exchange_rate, null: false
      t.datetime :expiry_date, null: false

      t.timestamps
    end

    add_index :orders, [:from_account_id, :to_account_id], unique: true
  end
end
