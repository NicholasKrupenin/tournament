class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :team, foreign_keys: true, null: false
      t.timestamps
    end
  end
end
