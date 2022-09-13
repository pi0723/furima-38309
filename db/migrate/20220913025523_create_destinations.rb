class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.string     :post_code, null: false
      t.string     :city,      null: false
      t.string     :address,   null: false
      t.string     :building
      t.string     :phone,     null: false
      t.integer    :area_id,   null: false
      t.references :order,     null: false, foreign_key: true
      t.timestamps
    end
  end
end


 