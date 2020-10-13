class CreateLandsatPds < ActiveRecord::Migration[6.0]
  def change
    create_table :landsat_pds do |t|
      t.string :key
      t.datetime :last_modified
      t.string :etag
      t.integer :size
      t.string :owner_id
      t.string :display_name
      t.string :storage_class
      t.string :fetch_url
      t.timestamps
    end
  end
end
