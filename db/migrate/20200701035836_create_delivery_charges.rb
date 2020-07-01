class CreateDeliveryCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_charges do |t|
      t.string :charge_rule,      null: false
      t.timestamps
    end
  end
end
