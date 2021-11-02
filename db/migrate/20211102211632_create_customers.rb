class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table(:customers, id: false) do |t|
      t.integer :id
      t.string :first_name
      t.string :last_name
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
