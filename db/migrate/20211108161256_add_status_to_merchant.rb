class AddStatusToMerchant < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :status, :string
  end
end