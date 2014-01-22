class RemoveDispensaries < ActiveRecord::Migration
  def change
    drop_table :dispensaries
  end
end
