class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :division
      t.timestamps
    end
  end
end
