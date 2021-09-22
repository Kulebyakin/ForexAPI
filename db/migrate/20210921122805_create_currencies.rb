class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :title, null: false, unique: true
      t.string :ticker, null: false, unique: true

      t.timestamps
    end
  end
end
