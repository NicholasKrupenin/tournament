class AddEnumToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :game, :integer, default: 0
    add_column :matches, :status, :integer, default: 1
  end
end
