class AddPriceToTeas < ActiveRecord::Migration[7.0]
  def change
    add_column :teas, :price, :integer
  end
end
