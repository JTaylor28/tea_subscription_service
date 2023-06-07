class ChangePriceColumnTypeInSubscriptions < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :price, :integer
  end
end
