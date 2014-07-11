class RemoveAddressFromPlace < ActiveRecord::Migration
  def change
    remove_column :places, :address, :string
  end
end
