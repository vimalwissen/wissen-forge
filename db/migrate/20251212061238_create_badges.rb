class CreateBadges < ActiveRecord::Migration[8.1]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :criteria
      t.string :image_url
      t.integer :level

      t.timestamps
    end
  end
end
